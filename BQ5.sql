WITH monthly_revenue_duration AS (
SELECT
        FORMAT(DateHour, 'yyyy') AS year,
        FORMAT(DateHour, 'MM') AS month,
        SUM(Total_revenue) AS revenue,
        SUM(Total_trip_duration) / 3600.0 AS duration_hours
    FROM
        FactTaxiMonthlySummary ft
        JOIN DimDate d ON ft.Date_id = d.Date_id
	 GROUP BY
        FORMAT(DateHour, 'yyyy'),
        FORMAT(DateHour, 'MM')
),

revenue_growth AS (
    SELECT
        month,
        year,
        revenue,
        duration_hours,
        LAG(revenue) OVER (ORDER BY year, month) AS prev_revenue,
        LAG(duration_hours) OVER (ORDER BY year, month) AS prev_duration_hours,
        (revenue - LAG(revenue) OVER (ORDER BY year, month)) / LAG(revenue) OVER (ORDER BY year, month) AS growth_rate
    FROM
        monthly_revenue_duration
)

SELECT
    month,
    year,
    revenue,
    prev_revenue,
    duration_hours,
    prev_duration_hours,
    growth_rate

FROM
    revenue_growth

ORDER BY
    growth_rate DESC;
