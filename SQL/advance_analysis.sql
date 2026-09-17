USE ad_global_freight;

WITH mode_summary AS (
    SELECT
        mode,
        COUNT(*) AS shipment_count,
        SUM(value_usd) AS total_value,
        AVG(`Delay_Time(hrs)`) AS average_delay
    FROM shipments
    GROUP BY mode
)
SELECT
    mode,
    shipment_count,
    ROUND(total_value, 2) AS total_value,
    ROUND(average_delay, 2) AS average_delay
FROM mode_summary
ORDER BY total_value DESC;


WITH delay_summary AS (
    SELECT
        `Delay_Reason` AS delay_reason,
        COUNT(*) AS shipment_count,
        SUM(`Delay_Time(hrs)`) AS total_delay_hours
    FROM shipments
    WHERE delay_flag = 1
    GROUP BY `Delay_Reason`
)
SELECT
    delay_reason,
    shipment_count,
    ROUND(total_delay_hours, 2) AS total_delay_hours,
    ROUND(
        total_delay_hours * 100.0 /
        SUM(total_delay_hours) OVER (),
        2
    ) AS percentage_of_total_delay
FROM delay_summary
ORDER BY total_delay_hours DESC;


WITH route_summary AS (
    SELECT
        route,
        COUNT(*) AS shipment_count,
        AVG(`Delay_Time(hrs)`) AS average_delay,
        SUM(`Delay_Time(hrs)`) AS total_delay
    FROM shipments
    GROUP BY route
)
SELECT
    route,
    shipment_count,
    ROUND(average_delay, 2) AS average_delay,
    ROUND(total_delay, 2) AS total_delay
FROM route_summary
WHERE shipment_count >= 20
ORDER BY average_delay DESC
LIMIT 10;


WITH yearly_summary AS (
    SELECT
        year,
        COUNT(*) AS shipment_count,
        SUM(value_usd) AS total_value
    FROM shipments
    GROUP BY year
)
SELECT
    year,
    shipment_count,
    ROUND(total_value, 2) AS total_value,
    ROUND(
        total_value * 100.0 /
        SUM(total_value) OVER (),
        2
    ) AS percentage_of_total_value
FROM yearly_summary
ORDER BY year;


WITH monthly_summary AS (
    SELECT
        year,
        month,
        month_number,
        COUNT(*) AS shipment_count,
        SUM(value_usd) AS monthly_value
    FROM shipments
    GROUP BY year, month, month_number
)
SELECT
    year,
    month,
    shipment_count,
    ROUND(monthly_value, 2) AS monthly_value,
    ROUND(
        SUM(monthly_value) OVER (
            PARTITION BY year
            ORDER BY month_number
        ),
        2
    ) AS cumulative_yearly_value
FROM monthly_summary
ORDER BY year, month_number;


SELECT
    shipment_id,
    route,
    mode,
    value_usd,
    `Delay_Time(hrs)`,
    RANK() OVER (
        ORDER BY value_usd DESC
    ) AS value_rank
FROM shipments
ORDER BY value_rank
LIMIT 20;


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


WITH mode_performance AS (
    SELECT
        mode,
        COUNT(*) AS shipment_count,
        AVG(`Delay_Time(hrs)`) AS average_delay,
        SUM(CASE WHEN delay_flag = 1 THEN 1 ELSE 0 END) AS delayed_shipments
    FROM shipments
    GROUP BY mode
)
SELECT
    mode,
    shipment_count,
    delayed_shipments,
    ROUND(average_delay, 2) AS average_delay,
    ROUND(
        delayed_shipments * 100.0 / shipment_count,
        2
    ) AS delay_rate
FROM mode_performance
ORDER BY delay_rate DESC;


SELECT
    year,
    month,
    month_number,
    COUNT(*) AS shipment_count,
    LAG(COUNT(*)) OVER (
        ORDER BY year, month_number
    ) AS previous_month_shipments,
    COUNT(*) -
    LAG(COUNT(*)) OVER (
        ORDER BY year, month_number
    ) AS shipment_change
FROM shipments
GROUP BY year, month, month_number
ORDER BY year, month_number;


WITH destination_summary AS (
    SELECT
        destination,
        COUNT(*) AS shipment_count,
        SUM(value_usd) AS total_value,
        AVG(`Delay_Time(hrs)`) AS average_delay
    FROM shipments
    GROUP BY destination
)
SELECT
    destination,
    shipment_count,
    ROUND(total_value, 2) AS total_value,
    ROUND(average_delay, 2) AS average_delay,
    DENSE_RANK() OVER (
        ORDER BY total_value DESC
    ) AS value_rank
FROM destination_summary
ORDER BY value_rank;


WITH route_performance AS (
    SELECT
        route,
        COUNT(*) AS shipment_count,
        AVG(`Delay_Time(hrs)`) AS average_delay
    FROM shipments
    GROUP BY route
)
SELECT
    route,
    shipment_count,
    ROUND(average_delay, 2) AS average_delay,
    CASE
        WHEN average_delay >= 10 THEN 'High Delay'
        WHEN average_delay >= 5 THEN 'Medium Delay'
        ELSE 'Low Delay'
    END AS performance_category
FROM route_performance
WHERE shipment_count >= 20
ORDER BY average_delay DESC;


SELECT
    mode,
    status,
    COUNT(*) AS shipment_count,
    ROUND(AVG(`Delay_Time(hrs)`), 2) AS average_delay
FROM shipments
GROUP BY mode, status
ORDER BY mode, shipment_count DESC;