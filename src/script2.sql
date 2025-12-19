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