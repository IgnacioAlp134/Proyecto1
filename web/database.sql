CREATE DATABASE db_eventos;
USE db_eventos;

CREATE TABLE Usuarios (
    id_usuario  INT    PRIMARY KEY      NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    correo      VARCHAR(150) NOT NULL,
    contrasena  VARCHAR(255) NOT NULL,
    rol         VARCHAR(20)  NOT NULL DEFAULT 'usuario',
    PRIMARY KEY (id_usuario),
    UNIQUE (correo)
);

CREATE TABLE Eventos (
    id_evento             INT            NOT NULL,
    nombre                VARCHAR(200)   NOT NULL,
    descripcion           TEXT           NOT NULL,
    fecha                 DATETIME       NOT NULL,
    foto                  VARCHAR(500),
    ubicacion             VARCHAR(300)   NOT NULL,
    entradas_totales      INT            NOT NULL,
    entradas_disponibles  INT            NOT NULL,
    precio                DECIMAL(10,2)  NOT NULL,
    PRIMARY KEY (id_evento)
);
CREATE TABLE Reservas (
    id_reserva           INT          NOT NULL,
    id_usuario           INT          NOT NULL,
    id_evento            INT          NOT NULL,
    cantidad             INT          NOT NULL,
    fecha_reserva        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    codigo_confirmacion  VARCHAR(20)  NOT NULL,
    estado               VARCHAR(20)  NOT NULL DEFAULT 'activa',
    PRIMARY KEY (id_reserva),
    UNIQUE (codigo_confirmacion)
);

INSERT INTO Usuarios (id_usuario, nombre, correo, contrasena, rol)
VALUES (3, 'Admin', 'admin@eventos.com', '0987', 'Administrador');

ALTER TABLE eventos ADD COLUMN categoria VARCHAR(50) NOT NULL DEFAULT 'Deportes';

ALTER TABLE Reservas ADD COLUMN zona VARCHAR(50);

DESCRIBE Eventos;

ALTER TABLE Eventos ADD COLUMN categoria VARCHAR(50) NOT NULL DEFAULT 'Deportes';

ALTER TABLE Reservas 
ADD CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento);
