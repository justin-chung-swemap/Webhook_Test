-- 1. Import your Logic/Schema file
-- Note: The path is relative to where you run psql from.
\i db_schema/module_risk/script.sql

BEGIN;

-- 2. Setup Test Data (The exact same setup as before)
INSERT INTO repos (name, url, language) VALUES ('calc-repo', 'http://test', 'Python');

INSERT INTO modules (repo_id, name, dir_path)
VALUES ((SELECT id FROM repos WHERE name = 'calc-repo'), 'RiskModule', '/src/risk');

INSERT INTO engineers (name, email) VALUES 
    ('Math Person A', 'a@calc.test'),
    ('Math Person B', 'b@calc.test'),
    ('Math Person C', 'c@calc.test');
