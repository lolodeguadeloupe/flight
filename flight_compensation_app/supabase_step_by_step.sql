-- Script de migration ÉTAPE PAR ÉTAPE pour diagnostiquer les problèmes
-- Exécutez chaque section une par une dans le SQL Editor de Supabase

-- ============================================================================
-- ÉTAPE 1: Vérification des permissions et de l'environnement
-- ============================================================================

-- Vérifier les tables existantes dans le schéma public
SELECT table_name, table_type 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- Vérifier les permissions
SELECT current_user, current_database();

-- ============================================================================
-- ÉTAPE 2: Créer la table airports (la plus simple)
-- ============================================================================

-- Supprimer la table airports si elle existe
DROP TABLE IF EXISTS public.airports CASCADE;

-- Créer la table airports
CREATE TABLE public.airports (
    id BIGSERIAL PRIMARY KEY,
    code TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- Vérifier que la table a été créée
SELECT table_name FROM information_schema.tables WHERE table_name = 'airports' AND table_schema = 'public';

-- Insérer des données de test
INSERT INTO public.airports (code, name, city, country) VALUES
    ('CDG', 'Charles de Gaulle Airport', 'Paris', 'France'),
    ('JFK', 'John F. Kennedy International Airport', 'New York', 'USA');

-- Vérifier les données
SELECT * FROM public.airports;

-- ============================================================================
-- ÉTAPE 3: Créer la table users
-- ============================================================================

-- Supprimer la table users si elle existe
DROP TABLE IF EXISTS public.users CASCADE;

-- Créer la table users
CREATE TABLE public.users (
    id UUID PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    display_name TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- Vérifier que la table a été créée
SELECT table_name FROM information_schema.tables WHERE table_name = 'users' AND table_schema = 'public';

-- ============================================================================
-- ÉTAPE 4: Créer la table claims (sans contraintes complexes d'abord)
-- ============================================================================

-- Supprimer la table claims si elle existe
DROP TABLE IF EXISTS public.claims CASCADE;

-- Créer la table claims (version simplifiée)
CREATE TABLE public.claims (
    id BIGSERIAL PRIMARY KEY,
    flight_number TEXT NOT NULL,
    departure_date DATE NOT NULL,
    departure_airport TEXT NOT NULL,
    arrival_airport TEXT NOT NULL,
    delay_duration INTEGER NOT NULL DEFAULT 0,
    delay_reason TEXT NOT NULL DEFAULT 'Unknown',
    passenger_name TEXT NOT NULL,
    passenger_email TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'DRAFT',
    estimated_compensation DECIMAL(10, 2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- Vérifier que la table a été créée
SELECT table_name FROM information_schema.tables WHERE table_name = 'claims' AND table_schema = 'public';

-- ============================================================================
-- ÉTAPE 5: Test d'insertion basique
-- ============================================================================

-- Tester une insertion simple
INSERT INTO public.claims (
    flight_number,
    departure_date,
    departure_airport,
    arrival_airport,
    delay_duration,
    delay_reason,
    passenger_name,
    passenger_email
) VALUES (
    'TEST123',
    '2024-01-01',
    'CDG',
    'JFK',
    4,
    'Technical issue',
    'Test User',
    'test@example.com'
);

-- Vérifier l'insertion
SELECT * FROM public.claims;

-- ============================================================================
-- ÉTAPE 6: Résumé et diagnostic
-- ============================================================================

-- Compter les enregistrements dans chaque table
SELECT 
    'airports' as table_name, COUNT(*) as record_count 
FROM public.airports
UNION ALL
SELECT 
    'users' as table_name, COUNT(*) as record_count 
FROM public.users
UNION ALL
SELECT 
    'claims' as table_name, COUNT(*) as record_count 
FROM public.claims;

-- Afficher un message de succès
SELECT 'Migration de base réussie!' as status;