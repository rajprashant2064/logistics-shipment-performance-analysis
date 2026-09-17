SELECT * FROM shipments LIMIT 5;

SELECT COUNT(*) AS total_shipments
FROM shipments;

SELECT MIN(date) AS start_date,
       MAX(date) AS end_date
FROM shipments;

SELECT mode, COUNT(*) AS shipments
FROM shipments
GROUP BY mode
ORDER BY shipments DESC;