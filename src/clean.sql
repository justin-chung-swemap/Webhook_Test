-- Person A (D=1, R=1)
INSERT INTO module_contributions (engineer_id, module_id, interaction_type)
VALUES 
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'DESIGNED'),
    ((SELECT id FROM engineers WHERE email='a@calc.test'), (SELECT id FROM modules WHERE name='RiskModule'), 'REVIEWED');
