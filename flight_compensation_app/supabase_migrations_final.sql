-- Migration script FINAL pour créer les tables de base pour l'application Flight Compensation
-- À exécuter dans le SQL Editor de Supabase
-- IMPORTANT: Ce script utilise BIGINT pour tous les IDs sauf user_id (UUID)

-- Supprimer les tables existantes si elles existent (dans l'ordre inverse des dépendances)
DROP TABLE IF EXISTS public.documents CASCADE;
DROP TABLE IF EXISTS public.claims CASCADE;
DROP TABLE IF EXISTS public.flights CASCADE;
DROP TABLE IF EXISTS public.airports CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;

-- Supprimer les fonctions et triggers
DROP FUNCTION IF EXISTS public.handle_updated_at() CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;

-- 1. Table des utilisateurs (users) - étend les utilisateurs auth de Supabase
CREATE TABLE public.users (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    display_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 2. Table des aéroports
CREATE TABLE public.airports (
    id BIGSERIAL PRIMARY KEY,
    code TEXT UNIQUE NOT NULL, -- IATA code (CDG, JFK, etc.)
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 3. Table des vols
CREATE TABLE public.flights (
    id BIGSERIAL PRIMARY KEY,
    flight_number TEXT NOT NULL,
    airline TEXT NOT NULL,
    departure_airport_code TEXT REFERENCES public.airports(code),
    arrival_airport_code TEXT REFERENCES public.airports(code),
    scheduled_departure TIMESTAMP WITH TIME ZONE NOT NULL,
    scheduled_arrival TIMESTAMP WITH TIME ZONE NOT NULL,
    actual_departure TIMESTAMP WITH TIME ZONE,
    actual_arrival TIMESTAMP WITH TIME ZONE,
    delay_reason TEXT,
    delay_reason_description TEXT,
    distance_km DECIMAL(10, 2) NOT NULL DEFAULT 0,
    jurisdiction TEXT NOT NULL DEFAULT 'EC261', -- EC261, ANAC400, etc.
    compensation_amount DECIMAL(10, 2),
    aircraft_type TEXT,
    gate TEXT,
    seat TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 4. Table des réclamations (claims) - BIGINT pour l'ID
CREATE TABLE public.claims (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    flight_id BIGINT REFERENCES public.flights(id),
    
    -- Informations du vol (dénormalisées pour simplicité)
    flight_number TEXT NOT NULL,
    departure_date DATE NOT NULL,
    departure_airport TEXT NOT NULL,
    arrival_airport TEXT NOT NULL,
    delay_duration INTEGER NOT NULL DEFAULT 0, -- en heures
    delay_reason TEXT NOT NULL DEFAULT 'Unknown',
    
    -- Informations du passager
    passenger_name TEXT NOT NULL,
    passenger_email TEXT NOT NULL,
    passenger_phone TEXT,
    passenger_address TEXT,
    
    -- Statut et montant
    status TEXT NOT NULL DEFAULT 'DRAFT' CHECK (status IN ('DRAFT', 'SUBMITTED', 'IN_PROGRESS', 'ACCEPTED', 'REJECTED', 'PAID')),
    estimated_compensation DECIMAL(10, 2),
    final_compensation DECIMAL(10, 2),
    
    -- Métadonnées
    submitted_at TIMESTAMP WITH TIME ZONE,
    processed_at TIMESTAMP WITH TIME ZONE,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 5. Table des documents - BIGINT pour TOUS les IDs
CREATE TABLE public.documents (
    id BIGSERIAL PRIMARY KEY,
    claim_id BIGINT REFERENCES public.claims(id) ON DELETE CASCADE NOT NULL,
    type TEXT NOT NULL DEFAULT 'OTHER' CHECK (type IN ('BOARDING_PASS', 'RECEIPT', 'ID_DOCUMENT', 'CORRESPONDENCE', 'OTHER')),
    file_name TEXT NOT NULL,
    file_path TEXT NOT NULL, -- chemin dans Supabase Storage
    file_size INTEGER,
    mime_type TEXT,
    ocr_data JSONB, -- données extraites par OCR
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 6. Politique de sécurité RLS (Row Level Security)

-- Activer RLS sur toutes les tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.claims ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.airports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.flights ENABLE ROW LEVEL SECURITY;

-- Policies pour users
CREATE POLICY "Users can view own profile" ON public.users
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.users
    FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON public.users
    FOR INSERT WITH CHECK (auth.uid() = id);

-- Policies pour claims
CREATE POLICY "Users can view own claims" ON public.claims
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can create own claims" ON public.claims
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own claims" ON public.claims
    FOR UPDATE USING (auth.uid() = user_id);

-- Policies pour documents
CREATE POLICY "Users can view own documents" ON public.documents
    FOR SELECT USING (
        auth.uid() = (SELECT user_id FROM public.claims WHERE id = claim_id)
    );

CREATE POLICY "Users can create own documents" ON public.documents
    FOR INSERT WITH CHECK (
        auth.uid() = (SELECT user_id FROM public.claims WHERE id = claim_id)
    );

-- Policies pour airports (lecture publique)
CREATE POLICY "Anyone can view airports" ON public.airports 
    FOR SELECT USING (true);

-- Policies pour flights (lecture publique)
CREATE POLICY "Anyone can view flights" ON public.flights 
    FOR SELECT USING (true);

-- 7. Triggers pour updated_at
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc'::text, NOW());
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER handle_users_updated_at BEFORE UPDATE ON public.users
    FOR EACH ROW EXECUTE PROCEDURE public.handle_updated_at();

CREATE TRIGGER handle_flights_updated_at BEFORE UPDATE ON public.flights
    FOR EACH ROW EXECUTE PROCEDURE public.handle_updated_at();

CREATE TRIGGER handle_claims_updated_at BEFORE UPDATE ON public.claims
    FOR EACH ROW EXECUTE PROCEDURE public.handle_updated_at();

-- 8. Insérer quelques aéroports de test
INSERT INTO public.airports (code, name, city, country) VALUES
    ('CDG', 'Charles de Gaulle Airport', 'Paris', 'France'),
    ('JFK', 'John F. Kennedy International Airport', 'New York', 'USA'),
    ('LHR', 'London Heathrow Airport', 'London', 'United Kingdom'),
    ('FRA', 'Frankfurt Airport', 'Frankfurt', 'Germany'),
    ('BCN', 'Barcelona-El Prat Airport', 'Barcelona', 'Spain'),
    ('GRU', 'São Paulo-Guarulhos International Airport', 'São Paulo', 'Brazil');

-- 9. Fonction pour créer automatiquement un profil utilisateur
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users (id, email, display_name)
    VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'display_name')
    ON CONFLICT (id) DO NOTHING;
    RETURN NEW;
END;
$$ language 'plpgsql' SECURITY DEFINER;

-- Trigger pour créer automatiquement un profil utilisateur
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- 10. Index pour optimiser les performances
CREATE INDEX idx_claims_user_id ON public.claims(user_id);
CREATE INDEX idx_claims_status ON public.claims(status);
CREATE INDEX idx_documents_claim_id ON public.documents(claim_id);
CREATE INDEX idx_flights_flight_number ON public.flights(flight_number);
CREATE INDEX idx_airports_code ON public.airports(code);

-- 11. Insérer un vol de test
INSERT INTO public.flights (
    flight_number, 
    airline, 
    departure_airport_code, 
    arrival_airport_code,
    scheduled_departure, 
    scheduled_arrival,
    distance_km,
    jurisdiction
) VALUES (
    'TEST123', 
    'Test Airlines', 
    'CDG', 
    'JFK',
    '2024-01-01 10:00:00+00', 
    '2024-01-01 18:00:00+00',
    5837.0,
    'EC261'
);

-- Fin du script de migration FINAL
-- Toutes les clés étrangères utilisent maintenant des types compatibles