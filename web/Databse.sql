CREATE DATABASE IF NOT EXISTS boletos_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE boletos_db;

CREATE TABLE IF NOT EXISTS Usuarios (
    id_usuario      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100)        NOT NULL,
    correo          VARCHAR(150)        NOT NULL UNIQUE,
    contraseña      VARCHAR(255)        NOT NULL,       
    rol             ENUM('cliente','administrador') NOT NULL DEFAULT 'cliente',
    fecha_registro  DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Eventos (
    id_evento           INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(200)        NOT NULL,
    descripcion         TEXT                NOT NULL,
    fecha               DATETIME            NOT NULL,
    foto                VARCHAR(500)        NULL,           -- ruta o URL de la imagen
    ubicacion           VARCHAR(300)        NOT NULL,
    entradas_totales    INT                 NOT NULL CHECK (entradas_totales > 0),
    entradas_disponibles INT               NOT NULL CHECK (entradas_disponibles >= 0),
    precio              DECIMAL(10,2)       NOT NULL CHECK (precio >= 0),
    activo              TINYINT(1)          NOT NULL DEFAULT 1,   -- soft delete
    fecha_creacion      DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_disponibles CHECK (entradas_disponibles <= entradas_totales)
);

CREATE TABLE IF NOT EXISTS Reservas (
    id_reserva          INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario          INT                 NOT NULL,
    id_evento           INT                 NOT NULL,
    cantidad            INT                 NOT NULL CHECK (cantidad > 0),
    fecha_reserva       DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
    codigo_confirmacion VARCHAR(20)         NOT NULL UNIQUE,
    estado              ENUM('activa','cancelada','modificada') NOT NULL DEFAULT 'activa',

    -- Llaves foráneas
    CONSTRAINT fk_reserva_usuario
        FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT fk_reserva_evento
        FOREIGN KEY (id_evento)  REFERENCES Eventos(id_evento)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX idx_eventos_fecha       ON Eventos(fecha);
CREATE INDEX idx_eventos_activo      ON Eventos(activo);
CREATE INDEX idx_reservas_usuario    ON Reservas(id_usuario);
CREATE INDEX idx_reservas_evento     ON Reservas(id_evento);
CREATE INDEX idx_reservas_codigo     ON Reservas(codigo_confirmacion);


-- Administrador por defecto (contraseña: admin123 → hash SHA-256)
INSERT INTO Usuarios (nombre, correo, contraseña, rol) VALUES
('Admin Principal', 'admin@boletos.com',
 SHA2('admin123', 256), 'administrador');

-- Usuarios de prueba
INSERT INTO Usuarios (nombre, correo, contraseña, rol) VALUES
('María López',   'maria@correo.com',  SHA2('pass1234', 256), 'cliente'),
('Carlos Pérez',  'carlos@correo.com', SHA2('pass1234', 256), 'cliente');

-- Eventos de prueba
INSERT INTO Eventos (nombre, descripcion, fecha, foto, ubicacion,
                     entradas_totales, entradas_disponibles, precio) VALUES
('Concierto Rock Nacional',
 'Una noche épica con las mejores bandas de rock del país.',
 '2025-09-15 20:00:00',
 'img/concierto_rock.jpg',
 'Estadio Nacional, San José',
 500, 500, 25000.00),

('Festival de Jazz',
 'Artistas internacionales en una velada mágica de jazz y blues.',
 '2025-10-05 18:30:00',
 'img/festival_jazz.jpg',
 'Teatro Melico Salazar, San José',
 200, 200, 15000.00),

('Obra de Teatro: Hamlet',
 'La clásica obra de Shakespeare interpretada por la compañía nacional.',
 '2025-08-20 19:00:00',
 'img/hamlet.jpg',
 'Teatro Popular Melico, San José',
 150, 150, 12000.00);


-- Vista: Reservas con detalle de usuario y evento
CREATE OR REPLACE VIEW vw_reservas_detalle AS
SELECT
    r.id_reserva,
    r.codigo_confirmacion,
    r.cantidad,
    r.fecha_reserva,
    r.estado,
    u.nombre        AS nombre_usuario,
    u.correo        AS correo_usuario,
    e.nombre        AS nombre_evento,
    e.fecha         AS fecha_evento,
    e.ubicacion,
    e.precio,
    (r.cantidad * e.precio) AS total_pagado
FROM Reservas r
JOIN Usuarios u ON r.id_usuario = u.id_usuario
JOIN Eventos  e ON r.id_evento  = e.id_evento;

-- Vista: Eventos disponibles (activos y con cupo)
CREATE OR REPLACE VIEW vw_eventos_disponibles AS
SELECT *
FROM Eventos
WHERE activo = 1
  AND entradas_disponibles > 0
  AND fecha > NOW();

DELIMITER $$

CREATE PROCEDURE sp_crear_reserva(
    IN  p_id_usuario  INT,
    IN  p_id_evento   INT,
    IN  p_cantidad    INT,
    OUT p_codigo      VARCHAR(20),
    OUT p_mensaje     VARCHAR(100)
)
BEGIN
    DECLARE v_disponibles INT DEFAULT 0;
    DECLARE v_codigo      VARCHAR(20);

    -- Bloquear fila del evento para evitar condiciones de carrera
    SELECT entradas_disponibles INTO v_disponibles
    FROM Eventos
    WHERE id_evento = p_id_evento AND activo = 1
    FOR UPDATE;

    IF v_disponibles IS NULL THEN
        SET p_mensaje = 'ERROR: Evento no encontrado o inactivo.';
        SET p_codigo  = NULL;

    ELSEIF v_disponibles < p_cantidad THEN
        SET p_mensaje = CONCAT('ERROR: Solo hay ', v_disponibles, ' entradas disponibles.');
        SET p_codigo  = NULL;

    ELSE
        -- Generar código único: RES + timestamp + random
        SET v_codigo = CONCAT('RES', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
                               LPAD(FLOOR(RAND() * 9999), 4, '0'));

        -- Insertar reserva
        INSERT INTO Reservas (id_usuario, id_evento, cantidad, codigo_confirmacion)
        VALUES (p_id_usuario, p_id_evento, p_cantidad, v_codigo);

        -- Descontar entradas
        UPDATE Eventos
        SET entradas_disponibles = entradas_disponibles - p_cantidad
        WHERE id_evento = p_id_evento;

        SET p_codigo  = v_codigo;
        SET p_mensaje = 'OK: Reserva creada exitosamente.';
    END IF;
END$$

DELIMITER ;