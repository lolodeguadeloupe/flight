-- Migration pour améliorer la table claims existante
-- Ajout de colonnes pour supporter le nouveau système de formulaire

-- Ajouter une colonne pour stocker toutes les données du formulaire
ALTER TABLE claims ADD COLUMN IF NOT EXISTS form_data JSONB;

-- Ajouter une colonne pour l'ID du brouillon source
ALTER TABLE claims ADD COLUMN IF NOT EXISTS draft_id UUID REFERENCES claim_drafts(id) ON DELETE SET NULL;

-- Ajouter des index pour les nouvelles colonnes
CREATE INDEX IF NOT EXISTS idx_claims_form_data ON claims USING GIN (form_data);
CREATE INDEX IF NOT EXISTS idx_claims_draft_id ON claims(draft_id);

-- Ajouter des colonnes pour améliorer le tracking
ALTER TABLE claims ADD COLUMN IF NOT EXISTS validation_errors JSONB DEFAULT '[]'::jsonb;
ALTER TABLE claims ADD COLUMN IF NOT EXISTS processing_notes TEXT;
ALTER TABLE claims ADD COLUMN IF NOT EXISTS last_status_change TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- Fonction pour mettre à jour automatiquement last_status_change
CREATE OR REPLACE FUNCTION update_claims_status_change()
RETURNS TRIGGER AS $$
BEGIN
  -- Mettre à jour seulement si le statut a changé
  IF OLD.status IS DISTINCT FROM NEW.status THEN
    NEW.last_status_change = NOW();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger pour mettre à jour automatiquement last_status_change
DROP TRIGGER IF EXISTS update_claims_status_change ON claims;
CREATE TRIGGER update_claims_status_change
  BEFORE UPDATE ON claims
  FOR EACH ROW
  EXECUTE FUNCTION update_claims_status_change();

-- Améliorer les contraintes de validation
ALTER TABLE claims ADD CONSTRAINT check_positive_compensation 
  CHECK (estimated_compensation IS NULL OR estimated_compensation >= 0);

-- Ajouter des contraintes pour les champs requis
ALTER TABLE claims ALTER COLUMN flight_number SET NOT NULL;
ALTER TABLE claims ALTER COLUMN departure_date SET NOT NULL;
ALTER TABLE claims ALTER COLUMN departure_airport SET NOT NULL;
ALTER TABLE claims ALTER COLUMN arrival_airport SET NOT NULL;
ALTER TABLE claims ALTER COLUMN passenger_name SET NOT NULL;
ALTER TABLE claims ALTER COLUMN passenger_email SET NOT NULL;

-- Contraintes de format pour les codes aéroports
ALTER TABLE claims ADD CONSTRAINT check_departure_airport_format 
  CHECK (LENGTH(departure_airport) = 3 AND departure_airport ~ '^[A-Z]{3}$');

ALTER TABLE claims ADD CONSTRAINT check_arrival_airport_format 
  CHECK (LENGTH(arrival_airport) = 3 AND arrival_airport ~ '^[A-Z]{3}$');

-- Contrainte pour vérifier que les aéroports de départ et d'arrivée sont différents
ALTER TABLE claims ADD CONSTRAINT check_different_airports 
  CHECK (departure_airport != arrival_airport);

-- Contrainte pour l'email
ALTER TABLE claims ADD CONSTRAINT check_email_format 
  CHECK (passenger_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- Commentaires pour la documentation
COMMENT ON COLUMN claims.form_data IS 'Toutes les données du formulaire en JSON pour référence complète';
COMMENT ON COLUMN claims.draft_id IS 'Référence vers le brouillon source de cette réclamation';
COMMENT ON COLUMN claims.validation_errors IS 'Erreurs de validation détectées lors du traitement';
COMMENT ON COLUMN claims.processing_notes IS 'Notes internes de traitement de la réclamation';
COMMENT ON COLUMN claims.last_status_change IS 'Timestamp du dernier changement de statut';