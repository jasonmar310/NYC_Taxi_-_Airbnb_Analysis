---USE [CS689_FinalProj];
CREATE OR ALTER FUNCTION is_within_neighborhood_bounds(
    @pickup_lat FLOAT,
    @pickup_lon FLOAT,
    @neighborhood_lat FLOAT,
    @neighborhood_lon FLOAT,
    @threshold FLOAT
)
RETURNS BIT
AS
BEGIN
    DECLARE @result BIT = 0;

    IF (ABS(@pickup_lat - @neighborhood_lat) <= @threshold) AND
       (ABS(@pickup_lon - @neighborhood_lon) <= @threshold)
    BEGIN
        SET @result = 1;
    END

    RETURN @result;
END;

