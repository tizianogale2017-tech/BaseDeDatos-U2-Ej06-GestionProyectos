-- Base de Datos I - Unidad 4 - Ej06: GestionProyectos
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS empleado_tarea;
DROP TABLE IF EXISTS proyecto_recurso;
DROP TABLE IF EXISTS EMPLEADO;
DROP TABLE IF EXISTS TAREA;
DROP TABLE IF EXISTS PERFIL_TECNICO;
DROP TABLE IF EXISTS FASE;
DROP TABLE IF EXISTS RECURSO_MATERIAL;
DROP TABLE IF EXISTS PROYECTO;

CREATE TABLE PROYECTO (
    id_proyecto INT PRIMARY KEY,
    codigo_proyecto VARCHAR(50) UNIQUE,
    nombre_comercial VARCHAR(50),
    descripcion_objetivos VARCHAR(100),
    fecha_inicio_prevista DATE,
    fecha_fin_estimada DATE,
    presupuesto_asignado DECIMAL(12,2)
);

CREATE TABLE RECURSO_MATERIAL (
    id_recurso INT PRIMARY KEY,
    numero_inventario VARCHAR(50),
    marca VARCHAR(50),
    modelo VARCHAR(50),
    tipo_recurso VARCHAR(50),
    estado_recurso VARCHAR(100),
    fecha_adquisicion DATE
);

CREATE TABLE FASE (
    id_fase INT PRIMARY KEY,
    id_proyecto INT,
    codigo_fase VARCHAR(100) UNIQUE,
    nombre_fase VARCHAR(50),
    orden_fase INT,
    fecha_inicio_fase DATE,
    estado_fase VARCHAR(100),
    FOREIGN KEY (id_proyecto) REFERENCES PROYECTO(id_proyecto)
);

CREATE TABLE PERFIL_TECNICO (
    id_perfil INT PRIMARY KEY,
    codigo_perfil VARCHAR(50) UNIQUE,
    nombre_perfil VARCHAR(50),
    descripcion_perfil VARCHAR(100),
    nivel_seniority VARCHAR(50),
    area_tecnica VARCHAR(50)
);

CREATE TABLE TAREA (
    id_tarea INT PRIMARY KEY,
    id_fase INT,
    codigo_tarea VARCHAR(50) UNIQUE,
    descripcion_tarea VARCHAR(50),
    estado_tarea VARCHAR(50),
    horas_estimadas TIME,
    fecha_limite DATE,
    prioridad VARCHAR(100),
    FOREIGN KEY (id_fase) REFERENCES FASE(id_fase)
);

CREATE TABLE EMPLEADO (
    id_empleado INT PRIMARY KEY,
    id_perfil INT,
    legajo VARCHAR(50),
    dni_empleado VARCHAR(100),
    nombre_empleado VARCHAR(50),
    apellido_empleado VARCHAR(50),
    categoria_laboral VARCHAR(100),
    fecha_ingreso DATE,
    FOREIGN KEY (id_perfil) REFERENCES PERFIL_TECNICO(id_perfil)
);

CREATE TABLE proyecto_recurso (
    id_proy_rec INT PRIMARY KEY,
    id_proyecto INT,
    id_recurso INT,
    fecha_asignacion DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (id_proyecto) REFERENCES PROYECTO(id_proyecto),
    FOREIGN KEY (id_recurso) REFERENCES RECURSO_MATERIAL(id_recurso)
);

CREATE TABLE empleado_tarea (
    id_emp_tarea INT PRIMARY KEY,
    id_empleado INT,
    id_tarea INT,
    horas_trabajadas INT,
    fecha_registro DATE,
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado),
    FOREIGN KEY (id_tarea) REFERENCES TAREA(id_tarea)
);

-- Datos de PROYECTO
INSERT INTO PROYECTO (id_proyecto, codigo_proyecto, nombre_comercial, presupuesto_asignado, fecha_inicio_prevista) VALUES (1, 'PRY-001', 'Portal Clientes', 12000, '2026-02-01');
INSERT INTO PROYECTO (id_proyecto, codigo_proyecto, nombre_comercial, presupuesto_asignado, fecha_inicio_prevista) VALUES (2, 'PRY-002', 'App Delivery', 8500, '2026-03-15');
INSERT INTO PROYECTO (id_proyecto, codigo_proyecto, nombre_comercial, presupuesto_asignado, fecha_inicio_prevista) VALUES (3, 'PRY-004', 'Sitio Web', 4000, '2026-04-01');
INSERT INTO PROYECTO (id_proyecto, codigo_proyecto, nombre_comercial, presupuesto_asignado, fecha_inicio_prevista) VALUES (4, 'PRY-005', 'Chatbot Soporte', 6500, '2026-05-01');

-- Datos de RECURSO_MATERIAL
INSERT INTO RECURSO_MATERIAL (id_recurso, numero_inventario, tipo_recurso, marca, modelo) VALUES (1, 'INV-1001', 'Notebook', 'Lenovo', 'ThinkPad T14');
INSERT INTO RECURSO_MATERIAL (id_recurso, numero_inventario, tipo_recurso, marca, modelo) VALUES (2, 'INV-1002', 'Servidor', 'Dell', 'PowerEdge R450');
INSERT INTO RECURSO_MATERIAL (id_recurso, numero_inventario, tipo_recurso, marca, modelo) VALUES (3, 'INV-1004', 'Monitor', 'Samsung', 'Odyssey G5');
INSERT INTO RECURSO_MATERIAL (id_recurso, numero_inventario, tipo_recurso, marca, modelo) VALUES (4, 'INV-1005', 'Tablet', 'TCL', 'TCL Tab 10L');

-- Datos de FASE
INSERT INTO FASE (id_fase, id_proyecto, nombre_fase, orden_fase, fecha_inicio_fase) VALUES (1, 1, 'Análisis', 1, '2026-02-01');
INSERT INTO FASE (id_fase, id_proyecto, nombre_fase, orden_fase, fecha_inicio_fase) VALUES (2, 1, 'Desarrollo', 2, '2026-03-01');
INSERT INTO FASE (id_fase, id_proyecto, nombre_fase, orden_fase, fecha_inicio_fase) VALUES (3, 2, 'Diseño', 1, '2026-03-15');
INSERT INTO FASE (id_fase, id_proyecto, nombre_fase, orden_fase, fecha_inicio_fase) VALUES (4, 2, 'Pruebas', 2, '2026-04-15');

-- Datos de PERFIL_TECNICO
INSERT INTO PERFIL_TECNICO (id_perfil, codigo_perfil, nombre_perfil, nivel_seniority, area_tecnica) VALUES (1, 'DEV-SR', 'Desarrollador Sr', 'Senior', 'Backend');
INSERT INTO PERFIL_TECNICO (id_perfil, codigo_perfil, nombre_perfil, nivel_seniority, area_tecnica) VALUES (2, 'QA', 'Analista QA', 'Semi Senior', 'Calidad');
INSERT INTO PERFIL_TECNICO (id_perfil, codigo_perfil, nombre_perfil, nivel_seniority, area_tecnica) VALUES (3, 'UX', 'Diseñador UX', 'Semi Senior', 'Diseño');
INSERT INTO PERFIL_TECNICO (id_perfil, codigo_perfil, nombre_perfil, nivel_seniority, area_tecnica) VALUES (4, 'PM', 'Project Manager', 'Senior', 'Gestión');

-- Datos de TAREA
INSERT INTO TAREA (id_tarea, id_fase, codigo_tarea, descripcion_tarea, estado_tarea) VALUES (1, 1, 'T-02', 'Armar casos de uso', 'Finalizada');
INSERT INTO TAREA (id_tarea, id_fase, codigo_tarea, descripcion_tarea, estado_tarea) VALUES (2, 2, 'T-03', 'Programar login', 'En curso');
INSERT INTO TAREA (id_tarea, id_fase, codigo_tarea, descripcion_tarea, estado_tarea) VALUES (3, 3, 'T-04', 'Diseñar wireframes', 'Finalizada');
INSERT INTO TAREA (id_tarea, id_fase, codigo_tarea, descripcion_tarea, estado_tarea) VALUES (4, 4, 'T-05', 'Test de carga', 'Pendiente');

-- Datos de EMPLEADO
INSERT INTO EMPLEADO (id_empleado, id_perfil, legajo, nombre_empleado, apellido_empleado) VALUES (1, 1, 'E-02', 'Bruno', 'Bravo');
INSERT INTO EMPLEADO (id_empleado, id_perfil, legajo, nombre_empleado, apellido_empleado) VALUES (2, 2, 'E-03', 'Carla', 'Cabrera');
INSERT INTO EMPLEADO (id_empleado, id_perfil, legajo, nombre_empleado, apellido_empleado) VALUES (3, 3, 'E-04', 'Diego', 'Domínguez');
INSERT INTO EMPLEADO (id_empleado, id_perfil, legajo, nombre_empleado, apellido_empleado) VALUES (4, 4, 'E-05', 'Elena', 'Estrada');

-- Datos de proyecto_recurso
INSERT INTO proyecto_recurso (id_proy_rec, id_proyecto, id_recurso, fecha_asignacion, fecha_devolucion) VALUES (1, 1, 1, '2026-03-01', '2026-06-30');
INSERT INTO proyecto_recurso (id_proy_rec, id_proyecto, id_recurso, fecha_asignacion, fecha_devolucion) VALUES (2, 1, 3, '2026-03-01', '2026-06-30');
INSERT INTO proyecto_recurso (id_proy_rec, id_proyecto, id_recurso, fecha_asignacion, fecha_devolucion) VALUES (3, 2, 2, '2026-04-10', '2026-09-01');
INSERT INTO proyecto_recurso (id_proy_rec, id_proyecto, id_recurso, fecha_asignacion, fecha_devolucion) VALUES (4, 3, 4, '2026-06-15', '2026-11-30');

-- Datos de empleado_tarea
INSERT INTO empleado_tarea (id_emp_tarea, id_empleado, id_tarea, horas_trabajadas, fecha_registro) VALUES (1, 1, 1, 10, '2026-03-10');
INSERT INTO empleado_tarea (id_emp_tarea, id_empleado, id_tarea, horas_trabajadas, fecha_registro) VALUES (2, 1, 2, 8, '2026-03-11');
INSERT INTO empleado_tarea (id_emp_tarea, id_empleado, id_tarea, horas_trabajadas, fecha_registro) VALUES (3, 2, 4, 5, '2026-04-20');
INSERT INTO empleado_tarea (id_emp_tarea, id_empleado, id_tarea, horas_trabajadas, fecha_registro) VALUES (4, 3, 3, 12, '2026-03-12');
