-- Script de nettoyage complet avant migration
-- À exécuter en premier si vous avez des tables existantes corrompues

-- ============================================================================
-- NETTOYAGE COMPLET
-- ============================================================================

-- Supprimer toutes les tables dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS public.documents CASCADE;
DROP TABLE IF EXISTS public.claims CASCADE;
DROP TABLE IF EXISTS public.flights CASCADE;
DROP TABLE IF EXISTS public.airports CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;

-- Supprimer les fonctions personnalisées
DROP FUNCTION IF EXISTS public.handle_updated_at() CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;

-- Supprimer les types énumérés personnalisés (s'ils existent)
DROP TYPE IF EXISTS public.claim_status CASCADE;
DROP TYPE IF EXISTS public.document_type CASCADE;

-- Vérifier que tout a été supprimé
SELECT table_name, table_type 
FROM information_schema.tables 
WHERE table_schema = 'public' 
    AND table_name IN ('users', 'airports', 'flights', 'claims', 'documents');

-- Si cette requête ne retourne aucune ligne, le nettoyage est réussi
SELECT 'Nettoyage terminé - Prêt pour la migration' as status;