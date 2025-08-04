-- Migration pour créer une table d'audit des modifications de formulaire
-- Permet de tracer toutes les modifications apportées aux brouillons

CREATE TABLE IF NOT EXISTS form_audit_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  draft_id UUID NOT NULL REFERENCES claim_drafts(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  action_type TEXT NOT NULL CHECK (action_type IN ('CREATE', 'UPDATE', 'VALIDATE', 'SUBMIT', 'DELETE')),
  step_index INTEGER,
  field_name TEXT,
  old_value JSONB,
  new_value JSONB,
  validation_result JSONB, -- Résultat de la validation (erreurs, etc.)
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index pour les requêtes fréquentes
CREATE INDEX IF NOT EXISTS idx_form_audit_draft_id ON form_audit_log(draft_id);
CREATE INDEX IF NOT EXISTS idx_form_audit_user_id ON form_audit_log(user_id);
CREATE INDEX IF NOT EXISTS idx_form_audit_created_at ON form_audit_log(created_at);
CREATE INDEX IF NOT EXISTS idx_form_audit_action_type ON form_audit_log(action_type);

-- Politique RLS
ALTER TABLE form_audit_log ENABLE ROW LEVEL SECURITY;

-- Les utilisateurs ne peuvent voir que leurs propres logs
CREATE POLICY "Users can view their own audit logs" ON form_audit_log
  FOR SELECT USING (auth.uid() = user_id);

-- Seul le système peut insérer des logs (via triggers ou fonctions sécurisées)
CREATE POLICY "System can insert audit logs" ON form_audit_log
  FOR INSERT WITH CHECK (true);

-- Fonction pour créer un log d'audit
CREATE OR REPLACE FUNCTION create_form_audit_log(
  p_draft_id UUID,
  p_user_id UUID,
  p_action_type TEXT,
  p_step_index INTEGER DEFAULT NULL,
  p_field_name TEXT DEFAULT NULL,
  p_old_value JSONB DEFAULT NULL,
  p_new_value JSONB DEFAULT NULL,
  p_validation_result JSONB DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  log_id UUID;
BEGIN
  INSERT INTO form_audit_log (
    draft_id,
    user_id,
    action_type,
    step_index,
    field_name,
    old_value,
    new_value,
    validation_result
  ) VALUES (
    p_draft_id,
    p_user_id,
    p_action_type,
    p_step_index,
    p_field_name,
    p_old_value,
    p_new_value,
    p_validation_result
  ) RETURNING id INTO log_id;
  
  RETURN log_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger automatique pour auditer les modifications de claim_drafts
CREATE OR REPLACE FUNCTION audit_claim_drafts_changes()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    PERFORM create_form_audit_log(
      NEW.id,
      NEW.user_id,
      'CREATE',
      NEW.current_step
    );
    RETURN NEW;
  ELSIF TG_OP = 'UPDATE' THEN
    -- Auditer les changements d'étape
    IF OLD.current_step IS DISTINCT FROM NEW.current_step THEN
      PERFORM create_form_audit_log(
        NEW.id,
        NEW.user_id,
        'UPDATE',
        NEW.current_step,
        'current_step',
        to_jsonb(OLD.current_step),
        to_jsonb(NEW.current_step)
      );
    END IF;
    
    -- Auditer les changements de données
    IF OLD.steps_data IS DISTINCT FROM NEW.steps_data THEN
      PERFORM create_form_audit_log(
        NEW.id,
        NEW.user_id,
        'UPDATE',
        NEW.current_step,
        'steps_data',
        OLD.steps_data,
        NEW.steps_data
      );
    END IF;
    
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    PERFORM create_form_audit_log(
      OLD.id,
      OLD.user_id,
      'DELETE',
      OLD.current_step
    );
    RETURN OLD;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Créer le trigger
DROP TRIGGER IF EXISTS audit_claim_drafts_trigger ON claim_drafts;
CREATE TRIGGER audit_claim_drafts_trigger
  AFTER INSERT OR UPDATE OR DELETE ON claim_drafts
  FOR EACH ROW
  EXECUTE FUNCTION audit_claim_drafts_changes();

-- Commentaires pour la documentation
COMMENT ON TABLE form_audit_log IS 'Journal d''audit de toutes les modifications des formulaires de réclamation';
COMMENT ON COLUMN form_audit_log.action_type IS 'Type d''action effectuée (CREATE, UPDATE, VALIDATE, SUBMIT, DELETE)';
COMMENT ON COLUMN form_audit_log.step_index IS 'Index de l''étape concernée par l''action';
COMMENT ON COLUMN form_audit_log.field_name IS 'Nom du champ modifié (si applicable)';
COMMENT ON COLUMN form_audit_log.validation_result IS 'Résultat de la validation avec erreurs détaillées';