WITH pickup_counts AS (
    SELECT
        l.Longitude,
        l.Latitude,
        COUNT(DISTINCT ft.Taxi_id) as pickup_count
    FROM
        FactTrip ft
        JOIN DimLocation l ON ft.Location_id = l.Location_id
    WHERE
        l.Location_type = 'Taxi Pickup'
    GROUP BY
        l.Longitude,
        l.Latitude
),

dropoff_counts AS (
    SELECT
        l.Longitude,
        l.Latitude,
        COUNT(DISTINCT ft.Taxi_id) as dropoff_count
    FROM
        FactTrip ft
        JOIN DimLocation l ON ft.Location_id = l.Location_id
    WHERE
        l.Location_type = 'Taxi Dropoff'
    GROUP BY
        l.Longitude,
        l.Latitude
),

pickup_ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY pickup_count DESC) AS rank
    FROM
        pickup_counts
),
dropoff_ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY dropoff_count DESC) AS rank
    FROM
        dropoff_counts
)

-- Top 3 most common pickup locations
SELECT
    Longitude,
    Latitude,
    pickup_count,
    'Pickup' as type
FROM
    pickup_ranked
WHERE
    rank <= 3

UNION ALL

-- Top 3 most common drop-off locations
SELECT
    Longitude,
    Latitude,
    dropoff_count,
    'Dropoff' as type
FROM
    dropoff_ranked
WHERE
    rank <= 3;
