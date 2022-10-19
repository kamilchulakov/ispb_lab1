INSERT INTO point(x, y) VALUES (0, 0), (1, 1), (1.5, 2), (2, 2.5), (3, 4), (4, 6.54321), (3, 10);
INSERT INTO point(x, y) VALUES (1.75, 3), (2, 3.33333);

INSERT INTO place_type(name) VALUES ('база'), ('ЛМА'), ('иные аномалии');
INSERT INTO place_type(name) VALUES ('лампа');

INSERT INTO place(name, point_id, place_type_id) VALUES ('база Клавий', 2, 1), ('ЛМА-1', 6, 2), ('странный кратер', 1, 3);

INSERT INTO wheel(brand) VALUES (null), ('Nokian Tyres');

INSERT INTO car(brand, model, left_top_wheel, right_top_wheel, left_back_wheel, right_back_wheel) VALUES
('Ricks Development', 'Space Cruiser', 1, 2, NULL, NULL);

INSERT INTO car(brand, model, left_top_wheel, right_top_wheel, left_back_wheel, right_back_wheel) VALUES
('Ricks Development', 'Normal Car', 1, 1, 1, 1);

INSERT INTO car_position(car_id, point_id) VALUES (1, 1);

INSERT INTO road(name) VALUES ('Дорога на север'), ('Дорога на Юму');

INSERT INTO road_points(road_id, point_id) VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 7);

INSERT INTO track(road_id, start_point, end_point, created_time) VALUES (1, 1, 1, now());

INSERT INTO track_type(name) VALUES ('small'), ('huge');
INSERT INTO track(road_id, start_point, end_point, created_time, type) VALUES (2, 1, 1, now(), 1);
INSERT INTO track(road_id, start_point, end_point, created_time, type) VALUES (1, 1, 1, now(), 2);
INSERT INTO track(road_id, start_point, end_point, created_time, type) VALUES (1, 1, 1, now(), 1);

UPDATE track
SET left_side = true
WHERE type IS NOT NULL;

UPDATE track
SET left_side = false
WHERE type IS NULL;

INSERT INTO road_work(road_id, start_point, end_point, start_time, end_time) VALUES (1, 2, 2, null, null), (1, 1, 1, now(), null);

INSERT INTO route(length, start_place, end_place) VALUES (300, 1, 2), (2, 1, 3);

INSERT INTO route_points(route_id, point_id) VALUES (1, 2), (1, 3), (1, 4), (1, 6), (2, 2);