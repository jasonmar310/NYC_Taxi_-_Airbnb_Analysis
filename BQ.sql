WITH avg_rental_rate AS (
    SELECT
        dL.neighborhood,
        AVG(aB.Price) AS avg_rental_rate
    FROM
        FactAirbnb aB
        JOIN DimLocation dL ON aB.Location_id = dL.Location_id
    GROUP BY
        dL.neighborhood
),

top_rental_neighborhoods AS (
    SELECT TOP 3
        neighborhood
    FROM
        avg_rental_rate
    ORDER BY
        avg_rental_rate DESC
),

top_rental_rooms AS (
    SELECT
        dL.neighborhood,
        aB.Room_type,
        aB.Revenue
    FROM
        FactAirbnb aB
        JOIN DimLocation dL ON aB.Location_id = dL.Location_id
        JOIN top_rental_neighborhoods tRN ON dL.neighborhood = tRN.neighborhood
)

SELECT
    neighborhood,
    Room_type,
    AVG(Revenue) AS avg_revenue
FROM
    top_rental_rooms
GROUP BY
    neighborhood,
    Room_type
ORDER BY
    neighborhood,
    avg_revenue DESC;
