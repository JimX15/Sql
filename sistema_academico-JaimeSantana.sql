
-- Crear base de datos y usarla
CREATE DATABASE IF NOT EXISTS sistema_academico;
USE sistema_academico;

-- Crear tablas
CREATE TABLE Departamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Estudiante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(100),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Profesor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    creditos INT,
    profesor_id INT,
    FOREIGN KEY (profesor_id) REFERENCES Profesor(id)
);

CREATE TABLE Clase (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT,
    aula VARCHAR(50),
    horario VARCHAR(50),
    FOREIGN KEY (curso_id) REFERENCES Curso(id)
);

CREATE TABLE Inscripcion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT,
    clase_id INT,
    fecha DATE,
    FOREIGN KEY (estudiante_id) REFERENCES Estudiante(id),
    FOREIGN KEY (clase_id) REFERENCES Clase(id)
);

CREATE TABLE Calificacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    inscripcion_id INT,
    nota DECIMAL(5,2),
    FOREIGN KEY (inscripcion_id) REFERENCES Inscripcion(id)
);

-- Consultas
-- 1
SELECT nombre, apellido FROM Estudiante ORDER BY apellido;

-- 2
SELECT * FROM Curso WHERE creditos > 3;

-- 3
SELECT e.nombre, e.apellido, c.nombre AS curso
FROM Estudiante e
INNER JOIN Inscripcion i ON e.id = i.estudiante_id
INNER JOIN Clase cl ON i.clase_id = cl.id
INNER JOIN Curso c ON cl.curso_id = c.id;

-- 4
SELECT e.nombre, e.apellido, c.nombre AS curso
FROM Estudiante e
LEFT JOIN Inscripcion i ON e.id = i.estudiante_id
LEFT JOIN Clase cl ON i.clase_id = cl.id
LEFT JOIN Curso c ON cl.curso_id = c.id;

-- 5
SELECT c.nombre, e.nombre AS estudiante
FROM Curso c
RIGHT JOIN Clase cl ON c.id = cl.curso_id
LEFT JOIN Inscripcion i ON cl.id = i.clase_id
LEFT JOIN Estudiante e ON i.estudiante_id = e.id;

-- 6
SELECT d.nombre AS departamento, COUNT(e.id) AS total_estudiantes
FROM Departamento d
LEFT JOIN Estudiante e ON d.id = e.departamento_id
GROUP BY d.id;

-- 7
SELECT e.nombre, e.apellido, AVG(ca.nota) AS promedio
FROM Estudiante e
JOIN Inscripcion i ON e.id = i.estudiante_id
JOIN Calificacion ca ON i.id = ca.inscripcion_id
GROUP BY e.id;

-- 8
SELECT cl.id AS clase_id, MAX(ca.nota) AS nota_max, MIN(ca.nota) AS nota_min
FROM Clase cl
JOIN Inscripcion i ON cl.id = i.clase_id
JOIN Calificacion ca ON i.id = ca.inscripcion_id
GROUP BY cl.id;

-- 9
SELECT e.nombre, e.apellido, AVG(ca.nota) AS promedio
FROM Estudiante e
JOIN Inscripcion i ON e.id = i.estudiante_id
JOIN Calificacion ca ON i.id = ca.inscripcion_id
GROUP BY e.id
ORDER BY promedio DESC
LIMIT 5;

-- 10
UPDATE Estudiante
SET correo = 'nuevo_correo@example.com'
WHERE id = 1;

-- 11
DELETE FROM Inscripcion
WHERE id = 1;
