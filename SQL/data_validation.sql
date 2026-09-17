USE ad_global_freight;

SELECT COUNT(*) AS total_rows
FROM shipments;

SELECT COUNT(DISTINCT shipment_id) AS unique_shipments
FROM shipments;

SELECT COUNT(*) AS duplicate_shipment_ids
FROM (
    SELECT shipment_id
    FROM shipments
    GROUP BY shipment_id
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT COUNT(*) AS missing_values
FROM shipments
WHERE shipment_id IS NULL
   OR date IS NULL
   OR origin IS NULL
   OR destination IS NULL
   OR mode IS NULL
   OR value_usd IS NULL
   OR `Delay_Time(hrs)` IS NULL
   OR status IS NULL
   OR Delay_Reason IS NULL;

SELECT MIN(date) AS minimum_date,
       MAX(date) AS maximum_date
FROM shipments;

SELECT MIN(weight_kg) AS minimum_weight,
       MAX(weight_kg) AS maximum_weight,
       MIN(value_usd) AS minimum_value,
       MAX(value_usd) AS maximum_value,
       MIN(`Delay_Time(hrs)`) AS minimum_delay,
       MAX(`Delay_Time(hrs)`) AS maximum_delay
FROM shipments;

SELECT COUNT(*) AS invalid_weight_records
FROM shipments
WHERE weight_kg <= 0;

SELECT COUNT(*) AS invalid_value_records
FROM shipments
WHERE value_usd <= 0;

SELECT COUNT(*) AS invalid_delay_records
FROM shipments
WHERE `Delay_Time(hrs)` < 0;

SELECT COUNT(*) AS duplicate_rows
FROM (
    SELECT shipment_id, COUNT(*) AS row_count
    FROM shipments
    GROUP BY shipment_id
    HAVING COUNT(*) > 1
) AS duplicate_check;

SELECT status,
       COUNT(*) AS shipment_count
FROM shipments
GROUP BY status
ORDER BY shipment_count DESC;

SELECT mode,
       COUNT(*) AS shipment_count
FROM shipments
GROUP BY mode
ORDER BY shipment_count DESC;

SELECT delay_flag,
       COUNT(*) AS shipment_count
FROM shipments
GROUP BY delay_flag
ORDER BY delay_flag;

SELECT Delay_Reason,
       COUNT(*) AS shipment_count
FROM shipments
GROUP BY Delay_Reason
ORDER BY shipment_count DESC;

SELECT year,
       COUNT(*) AS shipment_count
FROM shipments
GROUP BY year
ORDER BY year;

SELECT mode,
       COUNT(*) AS shipment_count,
       ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
       ROUND(MAX(`Delay_Time(hrs)`), 2) AS maximum_delay_hours
FROM shipments
GROUP BY mode
ORDER BY average_delay_hours DESC;

SELECT status,
       COUNT(*) AS shipment_count,
       ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
       ROUND(MAX(`Delay_Time(hrs)`), 2) AS maximum_delay_hours
FROM shipments
GROUP BY status
ORDER BY average_delay_hours DESC;

SELECT Delay_Reason,
       COUNT(*) AS shipment_count,
       ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
       ROUND(SUM(`Delay_Time(hrs)`), 2) AS total_delay_hours
FROM shipments
GROUP BY Delay_Reason
ORDER BY total_delay_hours DESC;