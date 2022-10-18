CREATE TABLE "point" (
    "id" int PRIMARY KEY,
    "x" float,
    "y" float
);

CREATE TABLE "place" (
    "id" int PRIMARY KEY,
    "point_id" int,
    "place_type_id" int
);

CREATE TABLE "place_type" (
    "id" int PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "road" (
    "id" int PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "road_points" (
    "id" int PRIMARY KEY,
    "road_id" int,
    "point_id" int
);

CREATE TABLE "road_work" (
    "id" int PRIMARY KEY,
    "road_id" int,
    "start_point" int,
    "end_point" int,
    "start_time" timestamp,
    "end_time" timestamp
);

CREATE TABLE "track" (
    "id" int PRIMARY KEY,
    "road_id" int,
    "start_point" int,
    "end_point" int,
    "created_time" timestamp
);

CREATE TABLE "route" (
    "id" int PRIMARY KEY,
    "start_place" int,
    "end_place" int
);

CREATE TABLE "route_points" (
    "id" int PRIMARY KEY,
    "route_id" int,
    "point_id" int
);

CREATE TABLE "car" (
    "id" int PRIMARY KEY,
    "brand" varchar,
    "model" varchar,
    "left_top_wheel" int,
    "right_top_wheel" int,
    "left_back_wheel" int,
    "right_back_wheel" int
);

CREATE TABLE "car_position" (
    "id" int PRIMARY KEY,
    "car_id" int,
    "point_id" int
);

CREATE TABLE "wheel" (
    "id" int PRIMARY KEY,
    "size" int,
    "brand" varchar
);

ALTER TABLE "place" ADD FOREIGN KEY ("point_id") REFERENCES "point" ("id");

ALTER TABLE "place" ADD FOREIGN KEY ("place_type_id") REFERENCES "place_type" ("id");

ALTER TABLE "road_points" ADD FOREIGN KEY ("road_id") REFERENCES "road" ("id");

ALTER TABLE "road_points" ADD FOREIGN KEY ("point_id") REFERENCES "point" ("id");

ALTER TABLE "road_work" ADD FOREIGN KEY ("road_id") REFERENCES "road" ("id");

ALTER TABLE "road_work" ADD FOREIGN KEY ("start_point") REFERENCES "point" ("id");

ALTER TABLE "road_work" ADD FOREIGN KEY ("end_point") REFERENCES "point" ("id");

ALTER TABLE "track" ADD FOREIGN KEY ("road_id") REFERENCES "road" ("id");

ALTER TABLE "track" ADD FOREIGN KEY ("start_point") REFERENCES "point" ("id");

ALTER TABLE "track" ADD FOREIGN KEY ("end_point") REFERENCES "point" ("id");

ALTER TABLE "route" ADD FOREIGN KEY ("start_place") REFERENCES "place" ("id");

ALTER TABLE "route" ADD FOREIGN KEY ("end_place") REFERENCES "place" ("id");

ALTER TABLE "route_points" ADD FOREIGN KEY ("route_id") REFERENCES "route" ("id");

ALTER TABLE "route_points" ADD FOREIGN KEY ("point_id") REFERENCES "point" ("id");

ALTER TABLE "car" ADD FOREIGN KEY ("left_top_wheel") REFERENCES "wheel" ("id");

ALTER TABLE "car" ADD FOREIGN KEY ("right_top_wheel") REFERENCES "wheel" ("id");

ALTER TABLE "car" ADD FOREIGN KEY ("left_back_wheel") REFERENCES "wheel" ("id");

ALTER TABLE "car" ADD FOREIGN KEY ("right_back_wheel") REFERENCES "wheel" ("id");

ALTER TABLE "car_position" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("id");

ALTER TABLE "car_position" ADD FOREIGN KEY ("point_id") REFERENCES "point" ("id");
