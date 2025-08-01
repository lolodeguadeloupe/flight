-- Migration script pour créer les tables de base pour l'application Flight Compensation
-- À exécuter dans le SQL Editor de Supabase

-- 1. Table des utilisateurs (users) - étend les utilisateurs auth de Supabase
CREATE TABLE IF NOT EXISTS public.users (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    display_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 2. Table des aéroports
CREATE TABLE IF NOT EXISTS public.airports (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    code TEXT UNIQUE NOT NULL, -- IATA code (CDG, JFK, etc.)
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 3. Table des vols
CREATE TABLE IF NOT EXISTS public.flights (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
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
    distance_km DECIMAL(10, 2) NOT NULL,
    jurisdiction TEXT NOT NULL, -- EC261, ANAC400, etc.
    compensation_amount DECIMAL(10, 2),
    aircraft_type TEXT,
    gate TEXT,
    seat TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 4. Table des réclamations (claims)
CREATE TABLE IF NOT EXISTS public.claims (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    flight_id UUID REFERENCES public.flights(id),
    
    -- Informations du vol (dénormalisées pour simplicité)
    flight_number TEXT NOT NULL,
    departure_date DATE NOT NULL,
    departure_airport TEXT NOT NULL,
    arrival_airport TEXT NOT NULL,
    delay_duration INTEGER NOT NULL, -- en heures
    delay_reason TEXT NOT NULL,
    
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

-- 5. Table des documents
CREATE TABLE IF NOT EXISTS public.documents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    claim_id UUID REFERENCES public.claims(id) ON DELETE CASCADE NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('BOARDING_PASS', 'RECEIPT', 'ID_DOCUMENT', 'CORRESPONDENCE', 'OTHER')),
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

-- Les utilisateurs peuvent seulement voir leurs propres données
CREATE POLICY "Users can view own profile" ON public.users
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.users
    FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON public.users
    FOR INSERT WITH CHECK (auth.uid() = id);

-- Les utilisateurs peuvent seulement voir leurs propres réclamations
CREATE POLICY "Users can view own claims" ON public.claims
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can create own claims" ON public.claims
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own claims" ON public.claims
    FOR UPDATE USING (auth.uid() = user_id);

-- Les utilisateurs peuvent seulement voir leurs propres documents
CREATE POLICY "Users can view own documents" ON public.documents
    FOR SELECT USING (
        auth.uid() = (SELECT user_id FROM public.claims WHERE id = claim_id)
    );

CREATE POLICY "Users can create own documents" ON public.documents
    FOR INSERT WITH CHECK (
        auth.uid() = (SELECT user_id FROM public.claims WHERE id = claim_id)
    );

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
    ('GRU', 'São Paulo-Guarulhos International Airport', 'São Paulo', 'Brazil')
ON CONFLICT (code) DO NOTHING;

-- 9. Fonction pour créer automatiquement un profil utilisateur
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users (id, email, display_name)
    VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'display_name');
    RETURN NEW;
END;
$$ language 'plpgsql' SECURITY DEFINER;

-- Trigger pour créer automatiquement un profil utilisateur
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- 10. Index pour optimiser les performances
CREATE INDEX IF NOT EXISTS idx_claims_user_id ON public.claims(user_id);
CREATE INDEX IF NOT EXISTS idx_claims_status ON public.claims(status);
CREATE INDEX IF NOT EXISTS idx_documents_claim_id ON public.documents(claim_id);
CREATE INDEX IF NOT EXISTS idx_flights_flight_number ON public.flights(flight_number);

-- Fin du script de migration