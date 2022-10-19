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

ALTER TABLE car ADD FOREIGN KEY (left_top_wheel) REFERENCES wheel (id);

ALTER TABLE car ADD FOREIGN KEY (right_top_wheel) REFERENCES wheel (id);

ALTER TABLE car ADD FOREIGN KEY (left_back_wheel) REFERENCES wheel (id);

ALTER TABLE car ADD FOREIGN KEY (right_back_wheel) REFERENCES wheel (id);

ALTER TABLE car_position ADD FOREIGN KEY (car_id) REFERENCES car (id);

ALTER TABLE car_position ADD FOREIGN KEY (point_id) REFERENCES point (id);
