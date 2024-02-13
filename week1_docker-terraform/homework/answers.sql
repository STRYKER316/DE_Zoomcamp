-- Question 3
SELECT
	COUNT(*) AS total_records
FROM
	green_taxi_trips_sep2019
WHERE
	date(lpep_pickup_datetime) = '2019-09-18'
	AND
	date(lpep_dropoff_datetime) = '2019-09-18'


-- Question 4
SELECT
	DATE(lpep_pickup_datetime) AS pickup_date
FROM
	green_taxi_trips_sep2019
WHERE trip_distance = (
	SELECT
		MAX(trip_distance)
	FROM
		green_taxi_trips_sep2019
)


-- Question 5


-- Question 6
