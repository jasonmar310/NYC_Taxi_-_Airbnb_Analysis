SELECT TOP 5
    dL.neighborhood,
    COUNT(aB.Airbnb_id) AS Airbnb_listings_count
FROM
    FactAirbnb aB
    JOIN DimLocation dL ON aB.Location_id = dL.Location_id
GROUP BY
    dL.neighborhood
ORDER BY
    Airbnb_listings_count DESC;

