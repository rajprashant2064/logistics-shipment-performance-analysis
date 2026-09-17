USE ad_global_freight;

SELECT COUNT(*) AS total_shipments
FROM shipments;

SELECT ROUND(SUM(value_usd), 2) AS total_shipment_value
FROM shipments;

SELECT ROUND(SUM(weight_kg), 2) AS total_weight_kg
FROM shipments;

SELECT ROUND(SUM(`Delay_Time(hrs)`), 2) AS total_delay_hours
FROM shipments;

SELECT 
    delay_flag,
    COUNT(*) AS shipment_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shipments), 2) AS percentage
FROM shipments
GROUP BY delay_flag
ORDER BY delay_flag;

SELECT 
    mode,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(value_usd), 2) AS average_shipment_value
FROM shipments
GROUP BY mode
ORDER BY shipment_count DESC;

SELECT 
    status,
    COUNT(*) AS shipment_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shipments), 2) AS percentage
FROM shipments
GROUP BY status
ORDER BY shipment_count DESC;

SELECT 
    year,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours
FROM shipments
GROUP BY year
ORDER BY year;

SELECT 
    month_number,
    month,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY month_number, month
ORDER BY month_number;

SELECT 
    quarter,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value
FROM shipments
GROUP BY quarter
ORDER BY quarter;

SELECT 
    origin,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY origin
ORDER BY shipment_count DESC
LIMIT 10;

SELECT 
    destination,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY destination
ORDER BY shipment_count DESC
LIMIT 10;

SELECT 
    product_description,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value
FROM shipments
GROUP BY product_description
ORDER BY total_shipment_value DESC
LIMIT 10;