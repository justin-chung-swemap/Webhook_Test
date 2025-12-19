DROP TRIGGER IF EXISTS trigger_update_blame_metrics ON commit_hunks CASCADE;
DROP TABLE IF EXISTS engineers, repos, skills, modules, files, commits, reviews, module_contributions, file_contributions, module_skills, engineer_skills, file_dependencies, commit_hunks, file_ownership_metrics CASCADE;
DROP TYPE IF EXISTS skill_type_enum, commit_type_enum, interaction_type_enum, dep_type_enum CASCADE;

-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 

-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 

-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 

-- These lines modified by JustinChungCYT
s_calculation AS (
   SELECT
       module_name,
       (
           (0.50 * num_wrote) +
           (0.25 * num_designed) +
           (0.25 * num_reviewed)
       ) / 5.0 AS score_s
   FROM
       contribution_counts
)
SELECT
   module_name,
   CASE
       WHEN score_s = 0 THEN NULL
       ELSE 1.0 / score_s
   END AS risk_metric
FROM
   s_calculation;

-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 


-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 


-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 

-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 

-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');

-- Person B (D=1->Total 2, R=1->Total 2)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 

-- These are lines written by JustinChungCYT
-- 1. Define the Logic as a View
-- This "saves" your complex math into a virtual table called 'module_risk_metrics'
CREATE OR REPLACE VIEW module_risk_metrics AS
WITH contribution_counts AS (
   SELECT
       m.name AS module_name, -- We keep the name so we can filter later
       COUNT(*) FILTER (WHERE mc.interaction_type = 'DESIGNED') AS num_designed,
       COUNT(*) FILTER (WHERE mc.interaction_type = 'WROTE') AS num_wrote,
       COUNT(*) FILTER (WHERE mc.interaction_type = 'REVIEWED') AS num_reviewed
   FROM
       modules m
   JOIN
       module_contributions mc ON m.id = mc.module_id
   GROUP BY
       m.name -- Calculate for every module found
),
s_calculation AS (
   SELECT
       module_name,
       (
           (0.50 * num_wrote) +
           (0.25 * num_designed) +
           (0.25 * num_reviewed)
       ) / 5.0 AS score_s
   FROM
       contribution_counts
)
SELECT
   module_name,
   CASE
       WHEN score_s = 0 THEN NULL
       ELSE 1.0 / score_s
   END AS risk_metric
FROM
   s_calculation;

-- main contributor (1): has a button to expand the full list:
-- list of top-5 contributors with >15% ownership
-- on-call: assigned (not included in the risk score)

-- Design with Blame in mind
-- Keep track of commits: use line chunks.
-- Blame has [start_line - end_line]; don't worry about performance for now.
