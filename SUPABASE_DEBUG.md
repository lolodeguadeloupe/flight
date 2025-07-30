# Debug Supabase Connection

## Problème identifié
L'erreur `ClientException: Failed to fetch` indique que l'URL Supabase ou la clé API est incorrecte.

## Solutions à tester

### 1. Vérifier l'URL Supabase
L'URL doit être au format : `https://[your-project-ref].supabase.co`

Dans votre dashboard Supabase :
- Allez dans Settings > API
- Copiez l'URL du projet (Project URL)
- Elle doit ressembler à : `https://abcdefghijklmnop.supabase.co`

### 2. Vérifier la clé API
- Dans Settings > API 
- Copiez la clé "anon public" (pas la service_role key)

### 3. Vérifier la table existe
Exécutez ce SQL dans l'éditeur Supabase :
```sql
CREATE TABLE IF NOT EXISTS claims (
    id BIGSERIAL PRIMARY KEY,
    flight_number VARCHAR(10) NOT NULL,
    departure_date VARCHAR(10) NOT NULL,
    departure_airport VARCHAR(3) NOT NULL,
    arrival_airport VARCHAR(3) NOT NULL,
    delay_duration INTEGER NOT NULL CHECK (delay_duration >= 0),
    delay_reason TEXT NOT NULL,
    passenger_name VARCHAR(255) NOT NULL,
    passenger_email VARCHAR(255) NOT NULL,
    estimated_compensation DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 4. Tester la connexion
Une fois les bonnes credentials obtenues, mettez à jour :