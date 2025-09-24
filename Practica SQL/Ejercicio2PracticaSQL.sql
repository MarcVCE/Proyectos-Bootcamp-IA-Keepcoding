-- Para comprobar que funcionaba usé https://onecompiler.com/postgresql  , tablesql no lo controlo tan bien y no podía/sabía ver los resultados (no me daba errores) y BigQuery no acepta 
-- claves primarias y secundarias como tipo de dato

create table alumno (
    id_alumno int,
    nombre_completo varchar(200),
    email varchar(100) unique,
    fecha_nacimiento date,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key (id_alumno)
);

create table profesor (
    id_profesor int,
    nombre_completo varchar(200),
    email varchar(100) unique,
    especialidad varchar(100),
    primary key (id_profesor)
);

create table bootcamp (
    id_bootcamp int,
    nombre varchar(100),
    tipo varchar(20),
    fecha_inicio date,
    fecha_fin date,
    primary key (id_bootcamp)
);

create table modulo (
    id_modulo int,
    nombre varchar(100),
    descripcion varchar(1000),
    fecha_inicio date,
    fecha_fin date,
    id_bootcamp int,
    primary key (id_modulo),
    foreign key (id_bootcamp) references bootcamp(id_bootcamp)
);

create table curso (
    id_curso int,
    id_alumno int,
    id_bootcamp int,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado varchar(100),
    calificacion decimal(3,2), 
    primary key (id_curso),
    foreign key (id_alumno) references alumno(id_alumno),
    foreign key (id_bootcamp) references bootcamp(id_bootcamp)
);

create table asignacion (
    id_asignacion int,
    id_profesor int,
    id_modulo int,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key (id_asignacion),
    foreign key (id_profesor) references profesor(id_profesor),
    foreign key (id_modulo) references modulo(id_modulo)
);

create table evaluacion (
    id_evaluacion int,
    id_alumno int,
    id_modulo int,
    calificacion  decimal(3,2),
    fecha_evaluacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key (id_evaluacion),
    foreign key (id_alumno) references alumno(id_alumno),
    foreign key (id_modulo) references modulo(id_modulo)
);


insert into alumno (id_alumno, nombre_completo, email, fecha_nacimiento)
values 
(1, 'Juan Pérez', 'juan.perez@email.com', date '1990-05-15'),
(2, 'Ana Gómez', 'ana.gomez@email.com', date '1992-11-23'),
(3, 'Luis Rodríguez', 'luis.rodriguez@email.com', date '1988-03-10');


insert into profesor (id_profesor, nombre_completo, email, especialidad)
values 
(1, 'Carlos Martín', 'carlos.martin@email.com', 'Desarrollo Web'),
(2, 'Marta Sánchez', 'marta.sanchez@email.com', 'Data Science'),
(3, 'Pedro Díaz', 'pedro.diaz@email.com', 'Marketing Digital');


insert into bootcamp (id_bootcamp, nombre, fecha_inicio, fecha_fin, tipo)
values  
(1, 'Bootcamp Full Stack', '2025-03-01', '2025-06-01', 'presencial'),
(2, 'Bootcamp Data Science', '2025-04-15', '2025-07-15', 'online');


insert into modulo (id_modulo, nombre, descripcion, fecha_inicio, fecha_fin, id_bootcamp)
values  
(1, 'HTML y CSS', 'Introducción a la creación de páginas web usando HTML y CSS.', date '2025-03-01', date '2025-03-15', 1),
(2, 'JavaScript Avanzado', 'Conceptos avanzados de JavaScript para el desarrollo web.', date '2025-03-16', date '2025-04-01', 1),
(3, 'Fundamentos de Machine Learning', 'Introducción a los algoritmos de Machine Learning.', date '2025-04-15', date '2025-05-15', 2),
(4, 'Análisis de Datos con Python', 'Uso de Python para análisis y manipulación de datos.', date '2025-04-16', date '2025-05-15', 2);


insert into curso (id_curso, id_alumno, id_bootcamp, estado, calificacion)
values  
(1, 1, 1, 'Inscrito', 8.75),
(2, 2, 1, 'Inscrito', 9.50),
(3, 3, 2, 'Inscrito', 7.25);


insert into asignacion (id_asignacion, id_profesor, id_modulo)
values  
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 2, 4);


insert into evaluacion (id_evaluacion, id_alumno, id_modulo, calificacion)
values 
(1, 1, 1, 9.00),
(2, 1, 2, 8.50),
(3, 2, 1, 9.75),
(4, 2, 2, 9.00),
(5, 3, 3, 7.50),
(6, 3, 4, 6.75);



select * from alumno;
select * from profesor;
select * from bootcamp;
select * from modulo;
select * from curso;
select * from asignacion;
select * from evaluacion;