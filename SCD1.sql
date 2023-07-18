-- Update existing records in DimLocation
UPDATE
    DimLocation_delta
SET
    DimLocation_delta.Location_type = Location_staging.Location_type,
    DimLocation_delta.Neighborhood = Location_staging.Neighborhood,
    DimLocation_delta.Borough = Location_staging.Borough,
    DimLocation_delta.Longitude = Location_staging.Longitude,
    DimLocation_delta.Latitude = Location_staging.Latitude
FROM
    DimLocation_delta
    INNER JOIN Location_staging ON DimLocation_delta.Location_id = Location_staging.Location_id;

SET IDENTITY_INSERT DimLocation_delta ON;

-- Insert new records into DimLocation
INSERT INTO DimLocation_delta (Location_id, Location_type, Neighborhood, Borough, Longitude, Latitude)
SELECT
    Location_id,
    Location_type,
    Neighborhood,
    Borough,
    Longitude,
    Latitude
FROM
    Location_staging
WHERE
    Location_id NOT IN (SELECT Location_id FROM DimLocation_delta);
