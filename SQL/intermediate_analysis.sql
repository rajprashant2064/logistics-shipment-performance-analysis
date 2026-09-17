USE ad_global_freight;

SELECT
    mode,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(value_usd), 2) AS average_shipment_value,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
    ROUND(MAX(`Delay_Time(hrs)`), 2) AS maximum_delay_hours
FROM shipments
GROUP BY mode
ORDER BY shipment_count DESC;


SELECT
    status,
    COUNT(*) AS shipment_count,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
    ROUND(MAX(`Delay_Time(hrs)`), 2) AS maximum_delay_hours,
    ROUND(SUM(value_usd), 2) AS total_shipment_value
FROM shipments
GROUP BY status
ORDER BY average_delay_hours DESC;


SELECT
    `Delay_Reason`,
    COUNT(*) AS shipment_count,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
    ROUND(SUM(`Delay_Time(hrs)`), 2) AS total_delay_hours
FROM shipments
GROUP BY `Delay_Reason`
ORDER BY total_delay_hours DESC;


SELECT
    year,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
    ROUND(
        SUM(CASE WHEN delay_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS delay_rate
FROM shipments
GROUP BY year
ORDER BY year;


SELECT
    year,
    month_number,
    month,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours
FROM shipments
GROUP BY year, month_number, month
ORDER BY year, month_number;


SELECT
    origin,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours
FROM shipments
GROUP BY origin
ORDER BY shipment_count DESC
LIMIT 10;


SELECT
    destination,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours
FROM shipments
GROUP BY destination
ORDER BY shipment_count DESC
LIMIT 10;


SELECT
    route,
    COUNT(*) AS shipment_count,
    ROUND(SUM(value_usd), 2) AS total_shipment_value,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
    ROUND(SUM(`Delay_Time(hrs)`), 2) AS total_delay_hours
FROM shipments
GROUP BY route
ORDER BY shipment_count DESC
LIMIT 10;


SELECT
    route,
    COUNT(*) AS shipment_count,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
    ROUND(SUM(`Delay_Time(hrs)`), 2) AS total_delay_hours
FROM shipments
GROUP BY route
HAVING COUNT(*) >= 20
ORDER BY average_delay_hours DESC
LIMIT 10;


SELECT
    shipment_id,
    origin,
    destination,
    route,
    mode,
    value_usd,
    `Delay_Time(hrs)`,
    `Delay_Reason`,
    status
FROM shipments
ORDER BY value_usd DESC
LIMIT 10;


WITH mode_performance AS (
    SELECT
        mode,
        COUNT(*) AS shipment_count,
        ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay_hours,
        ROUND(
            SUM(CASE WHEN delay_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS delay_rate
    FROM shipments
    GROUP BY mode
)
SELECT
    mode,
    shipment_count,
    average_delay_hours,
    delay_rate
FROM mode_performance
ORDER BY delay_rate DESC;


SELECT
    shipment_id,
    route,
    mode,
    value_usd,
    `Delay_Time(hrs)`,
    RANK() OVER (
        ORDER BY `Delay_Time(hrs)` DESC
    ) AS delay_rank
FROM shipments
ORDER BY delay_rank
LIMIT 20;


SELECT
    year,
    month,
    shipment_count,
    total_shipment_value,
    SUM(total_shipment_value) OVER (
        ORDER BY year, month_number
    ) AS cumulative_value
FROM (
    SELECT
        year,
        month,
        month_number,
        COUNT(*) AS shipment_count,
        ROUND(SUM(value_usd), 2) AS total_shipment_value
    FROM shipments
    GROUP BY year, month, month_number
) AS monthly_data
ORDER BY year, month_number;