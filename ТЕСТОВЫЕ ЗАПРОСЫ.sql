SELECT * FROM road
JOIN road_work rw on road.id = rw.road_id
WHERE rw.start_time IS NULL;

SELECT (car.brand, car.model, r.name) FROM car
JOIN car_position cp on car.id = cp.car_id
JOIN road_points rp on cp.point_id = rp.point_id
JOIN road r on rp.road_id = r.id;

SELECT COUNT(cp.id), road.name FROM road
JOIN road_points rp on road.id = rp.road_id
JOIN car_position cp on rp.point_id = cp.point_id
GROUP BY road.id;

SELECT (track.created_time, cp.car_id) FROM track
JOIN car_position cp on (cp.point_id = track.start_point OR cp.point_id = track.end_point)
