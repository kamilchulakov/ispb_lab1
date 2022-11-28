CREATE TABLE point (
    id SERIAL PRIMARY KEY,
    x float,
    y float
);

CREATE TABLE place (
    id SERIAL PRIMARY KEY,
    name varchar NOT NULL,
    point_id int,
    place_type_id int
);

CREATE TABLE place_type (
    id SERIAL PRIMARY KEY,
    name varchar NOT NULL
);

CREATE TABLE road (
    id SERIAL PRIMARY KEY,
    name varchar
);

CREATE TABLE road_points (
    id SERIAL PRIMARY KEY,
    road_id int,
    point_id int
);

CREATE TABLE road_work (
    id SERIAL PRIMARY KEY,
    road_id int,
    start_point int,
    end_point int,
    start_time timestamp,
    end_time timestamp
);

CREATE TABLE track (
    id SERIAL PRIMARY KEY,
    road_id int,
    start_point int,
    end_point int,
    created_time timestamp
);

CREATE TABLE track_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR
);

ALTER TABLE track ADD COLUMN type int REFERENCES track_type(id);

ALTER TABLE track ADD COLUMN left_side bool;

CREATE TABLE route (
    id SERIAL PRIMARY KEY,
    length int CONSTRAINT positive_length CHECK (length > 0),
    start_place int,
    end_place int
);

CREATE TABLE route_points (
    id SERIAL PRIMARY KEY,
    route_id int,
    point_id int
);

CREATE TABLE car (
    id SERIAL PRIMARY KEY,
    brand varchar,
    model varchar,
    left_top_wheel int,
    right_top_wheel int,
    left_back_wheel int,
    right_back_wheel int
);

CREATE TABLE car_position (
    id SERIAL PRIMARY KEY,
    car_id int,
    point_id int
);

CREATE TABLE wheel (
    id SERIAL PRIMARY KEY,
    size int,
    brand varchar
);

ALTER TABLE place ADD FOREIGN KEY (point_id) REFERENCES point (id);

ALTER TABLE place ADD FOREIGN KEY (place_type_id) REFERENCES place_type (id);

ALTER TABLE place ADD CONSTRAINT unique_place UNIQUE(point_id);

ALTER TABLE road_points ADD FOREIGN KEY (road_id) REFERENCES road (id);

ALTER TABLE road_points ADD FOREIGN KEY (point_id) REFERENCES point (id);

ALTER TABLE road_points ADD CONSTRAINT unique_pair_road UNIQUE(road_id, point_id);
ALTER TABLE road_points DROP COLUMN id;

ALTER TABLE road_work ADD FOREIGN KEY (road_id) REFERENCES road (id);

ALTER TABLE road_work ADD FOREIGN KEY (start_point) REFERENCES point (id);

ALTER TABLE road_work ADD FOREIGN KEY (end_point) REFERENCES point (id);

ALTER TABLE road_work ADD CONSTRAINT start_time_is_less CHECK (end_time IS NULL OR start_time < end_time);

ALTER TABLE track ADD FOREIGN KEY (road_id) REFERENCES road (id);

ALTER TABLE track ADD FOREIGN KEY (start_point) REFERENCES point (id);

ALTER TABLE track ADD FOREIGN KEY (end_point) REFERENCES point (id);

ALTER TABLE route ADD FOREIGN KEY (start_place) REFERENCES place (id);

ALTER TABLE route ADD FOREIGN KEY (end_place) REFERENCES place (id);

ALTER TABLE route_points ADD FOREIGN KEY (route_id) REFERENCES route (id);

ALTER TABLE route_points ADD FOREIGN KEY (point_id) REFERENCES point (id);

ALTER TABLE route_points ADD CONSTRAINT unique_pair UNIQUE(route_id, point_id);
ALTER TABLE route_points DROP COLUMN id;

ALTER TABLE car ADD FOREIGN KEY (left_top_wheel) REFERENCES wheel (id);

ALTER TABLE car ADD FOREIGN KEY (right_top_wheel) REFERENCES wheel (id);

ALTER TABLE car ADD FOREIGN KEY (left_back_wheel) REFERENCES wheel (id);

ALTER TABLE car ADD FOREIGN KEY (right_back_wheel) REFERENCES wheel (id);

ALTER TABLE car_position ADD FOREIGN KEY (car_id) REFERENCES car (id);

ALTER TABLE car_position ADD FOREIGN KEY (point_id) REFERENCES point (id);

DROP VIEW road_road_points, road_route_points, road_track;

CREATE VIEW road_road_points AS
    SELECT r.id as road_id, r.name as road_name, p.x as road_point_x, p.y as road_point_y FROM road r
    JOIN road_points rp on r.id = rp.road_id
    JOIN point p on rp.point_id = p.id;


CREATE OR REPLACE VIEW road_route_points AS
SELECT r.id as route_id, r.length as route_length, p2.name as place, pt.name as place_type, p.id as route_point_id, p.x as route_point_x, p.y as route_point_y FROM route r
JOIN route_points rp on r.id = rp.route_id
JOIN point p on rp.point_id = p.id
JOIN place p2 on p.id = p2.point_id
JOIN place_type pt on p2.place_type_id = pt.id;

CREATE OR REPLACE VIEW road_track AS
    SELECT r.id as road_id, r.name as road_name, tt.name as track_type, t.created_time as create_time, t.left_side as left_side, t.start_point as start_point, t.end_point as end_point FROM track t
    LEFT JOIN road r on r.id = t.road_id
    LEFT JOIN track_type tt on t.type = tt.id;

CREATE OR REPLACE VIEW road_car_position AS
    SELECT p.x as point_x, p.y as point_y, c.id as car_id, c.brand as car_brand, c.model as car_model FROM car c
    LEFT JOIN car_position cp on cp.car_id = c.id
    LEFT JOIN point p on p.id = cp.point_id;