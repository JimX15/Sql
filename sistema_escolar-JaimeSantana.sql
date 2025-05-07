
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS sistema_escolar;
USE sistema_escolar;

-- Tabla Departamento
CREATE TABLE departamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla Profesores
CREATE TABLE profesores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamento(id)
);

-- Tabla Cursos
CREATE TABLE curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    creditos INT,
    profesor_id INT,
    FOREIGN KEY (profesor_id) REFERENCES profesores(id)
);

-- Tabla Estudiantes
CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE
);

-- Tabla Direcciones
CREATE TABLE direcciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT,
    calle VARCHAR(100),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id)
);

-- Tabla Matriculas
CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT,
    curso_id INT,
    fecha DATE,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);
