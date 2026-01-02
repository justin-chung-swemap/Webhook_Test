CREATE TABLE line_ownership (
    id SERIAL PRIMARY KEY,
    file_id INTEGER REFERENCES files(id) ON DELETE CASCADE,
    engineer_id INTEGER REFERENCES engineers(id) ON DELETE CASCADE,
    
    -- RANGE OPTIMIZATION: Use int4range instead of start_line/end_line
    -- Example: [1, 100) includes 1 up to 99.
    line_range int4range NOT NULL, 
    
    last_updated_commit TEXT, -- [cite: 135]
    
    -- Prevent overlapping ownership for the same lines in the same file
    EXCLUDE USING gist (file_id WITH =, line_range WITH &&)
);

-- Create Indexes for performance
CREATE INDEX idx_contributions_module_id
ON module_contributions(module_id, interaction_type);

CREATE INDEX idx_modules_name ON modules(name);
