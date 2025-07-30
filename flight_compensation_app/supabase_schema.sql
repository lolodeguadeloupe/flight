-- Claims table for flight compensation requests
CREATE TABLE claims (
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
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'submitted', 'in_progress', 'accepted', 'rejected')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add indexes for better performance
CREATE INDEX idx_claims_passenger_email ON claims(passenger_email);
CREATE INDEX idx_claims_status ON claims(status);
CREATE INDEX idx_claims_created_at ON claims(created_at);

-- Enable Row Level Security (RLS)
ALTER TABLE claims ENABLE ROW LEVEL SECURITY;

-- RLS Policy: Users can only see their own claims
CREATE POLICY "Users can view their own claims" ON claims
    FOR SELECT USING (passenger_email = auth.email());

-- RLS Policy: Users can insert their own claims
CREATE POLICY "Users can insert their own claims" ON claims
    FOR INSERT WITH CHECK (passenger_email = auth.email());

-- RLS Policy: Users can update their own claims (limited fields)
CREATE POLICY "Users can update their own claims" ON claims
    FOR UPDATE USING (passenger_email = auth.email());

-- Trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_claims_updated_at 
    BEFORE UPDATE ON claims 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Example Edge Function for compensation calculation
CREATE OR REPLACE FUNCTION calculate_compensation(
    departure_airport TEXT,
    arrival_airport TEXT,
    delay_duration INTEGER,
    flight_date TEXT
)
RETURNS JSON AS $$
DECLARE
    distance INTEGER := 0;
    compensation DECIMAL := 0;
    result JSON;
BEGIN
    -- Simple distance calculation (you'd use real airport coordinates)
    -- This is a simplified example
    IF departure_airport IN ('CDG', 'ORY', 'LHR', 'AMS') AND 
       arrival_airport IN ('CDG', 'ORY', 'LHR', 'AMS') THEN
        distance := 1000; -- Short haul
    ELSIF departure_airport IN ('CDG', 'ORY') AND 
          arrival_airport IN ('JFK', 'LAX', 'DXB') THEN
        distance := 6000; -- Long haul
    ELSE
        distance := 2500; -- Medium haul
    END IF;

    -- Calculate compensation based on EC261 rules
    IF delay_duration < 180 THEN -- Less than 3 hours
        compensation := 0;
    ELSIF distance <= 1500 THEN -- Short haul
        compensation := 250;
    ELSIF distance <= 3500 THEN -- Medium haul
        compensation := 400;
    ELSE -- Long haul
        IF delay_duration >= 240 THEN -- 4+ hours for long haul
            compensation := 600;
        ELSE
            compensation := 0;
        END IF;
    END IF;

    result := json_build_object(
        'compensation', compensation,
        'distance', distance,
        'eligible', compensation > 0,
        'regulation', 'EC261'
    );

    RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;