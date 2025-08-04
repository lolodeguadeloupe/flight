-- Migration pour créer la table claim_drafts
-- Cette table stocke les brouillons de réclamations étape par étape

CREATE TABLE IF NOT EXISTS claim_drafts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  form_id TEXT NOT NULL, -- Identifiant unique du formulaire généré côté client
  current_step INTEGER NOT NULL DEFAULT 0,
  steps_data JSONB NOT NULL DEFAULT '[]'::jsonb,
  estimated_compensation DECIMAL(10,2),
  is_draft BOOLEAN NOT NULL DEFAULT true,
  is_active BOOLEAN NOT NULL DEFAULT true,
  submitted_claim_id UUID REFERENCES claims(id) ON DELETE SET NULL,
  submitted_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Contrainte unique pour éviter les doublons
  UNIQUE(user_id, form_id)
);

-- Index pour les requêtes fréquentes
CREATE INDEX IF NOT EXISTS idx_claim_drafts_user_id ON claim_drafts(user_id);
CREATE INDEX IF NOT EXISTS idx_claim_drafts_active ON claim_drafts(user_id, is_active);
CREATE INDEX IF NOT EXISTS idx_claim_drafts_updated_at ON claim_drafts(updated_at);

-- Fonction pour mettre à jour automatiquement updated_at
CREATE OR REPLACE FUNCTION update_claim_drafts_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger pour mettre à jour automatiquement updated_at
DROP TRIGGER IF EXISTS update_claim_drafts_updated_at ON claim_drafts;
CREATE TRIGGER update_claim_drafts_updated_at
  BEFORE UPDATE ON claim_drafts
  FOR EACH ROW
  EXECUTE FUNCTION update_claim_drafts_updated_at();

-- Politique RLS (Row Level Security)
ALTER TABLE claim_drafts ENABLE ROW LEVEL SECURITY;

-- Les utilisateurs ne peuvent voir que leurs propres brouillons
CREATE POLICY "Users can view their own drafts" ON claim_drafts
  FOR SELECT USING (auth.uid() = user_id);

-- Les utilisateurs ne peuvent créer que leurs propres brouillons
CREATE POLICY "Users can create their own drafts" ON claim_drafts
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Les utilisateurs ne peuvent mettre à jour que leurs propres brouillons
CREATE POLICY "Users can update their own drafts" ON claim_drafts
  FOR UPDATE USING (auth.uid() = user_id);

-- Les utilisateurs ne peuvent supprimer que leurs propres brouillons
CREATE POLICY "Users can delete their own drafts" ON claim_drafts
  FOR DELETE USING (auth.uid() = user_id);

-- Commentaires pour la documentation
COMMENT ON TABLE claim_drafts IS 'Stockage des brouillons de réclamations avec validation étape par étape';
COMMENT ON COLUMN claim_drafts.form_id IS 'Identifiant unique du formulaire généré côté client';
COMMENT ON COLUMN claim_drafts.current_step IS 'Index de l''étape actuelle (0-based)';
COMMENT ON COLUMN claim_drafts.steps_data IS 'Données JSON des étapes avec validation et erreurs';
COMMENT ON COLUMN claim_drafts.estimated_compensation IS 'Montant estimé de l''indemnisation calculé';
COMMENT ON COLUMN claim_drafts.is_active IS 'Indique si le brouillon est encore actif (non soumis)';
COMMENT ON COLUMN claim_drafts.submitted_claim_id IS 'ID de la réclamation finale si soumise';