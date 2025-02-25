CREATE TABLE Component (
    component_id SERIAL PRIMARY KEY,
    name TEXT,
    type TEXT,
    material TEXT,
    transparency INT CHECK(transparency >= 0 AND transparency <= 100) 
);

CREATE TABLE Structure (
    structure_id SERIAL PRIMARY KEY,
    element_type TEXT,
    element_count INT 
);

CREATE TABLE Appearance (
    appearance_id SERIAL PRIMARY KEY,
    shape TEXT,
    color TEXT,
    visual_similarity TEXT,
    component_id INT REFERENCES Component(component_id)
);

CREATE TABLE Device (
    device_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    status BOOLEAN 
);

CREATE TABLE Person (
    person_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    gender VARCHAR(6) 
);

CREATE TABLE Action (
    action_id SERIAL PRIMARY KEY,
    action_type TEXT NOT NULL,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    person_id INT REFERENCES Person(person_id),
    device_id INT REFERENCES Device(device_id)
    CHECK (end_time > start_time)
);

CREATE TABLE Component_Structure (
    component_id INT REFERENCES Component(component_id),
    structure_id INT REFERENCES Structure(structure_id),
    PRIMARY KEY (component_id, structure_id)
);

INSERT INTO Component (name, type, material, transparency) 
VALUES ('Пластинка', 'Прибор', 'Пластик', 50);

INSERT INTO Structure (element_type, element_count) 
VALUES ('Проволочки', 100);

INSERT INTO Appearance (shape, color, visual_similarity, component_id) 
VALUES ('Прямоугольник', NULL, 'Вафля', 1);

INSERT INTO Component_Structure (component_id, structure_id) 
VALUES (1, 1);

INSERT INTO Person (name, gender) 
VALUES ('Боумен', 'male');

INSERT INTO Device (name, status) 
VALUES ('Электронный блок', false);

INSERT INTO Action (action_type, start_time, end_time, person_id, device_id) 
VALUES (
    'Отключение блока',
    '2024-12-31 23:59:59',
    '2025-01-01 00:00:00',
    1,
    1
);
