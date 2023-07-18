--- SCD Type 2
CREATE TABLE DimTaxi_New (
	    Taxi_id INT,
	    Id VARCHAR(50),
	    Passenger_count INT,
	    Trip_distance FLOAT,
	    Fare_amount FLOAT,
	    Trip_duration INT,
	    Effective_date DATETIME,
	    End_date DATETIME,
	    Is_current BIT
);


--- Insert value
INSERT INTO DimTaxi_New (Id, Passenger_count, Trip_duration, Effective_date, End_date, Is_current) 
VALUES 
('id0000001', 2, 600, '2022-04-25', NULL, 1), --- maintain
('id5000003', 4, 1200, '2022-04-23', NULL, 1), --- new
('id5000005', 5, 900, '2022-04-22', NULL, 1), --- new
('id0000008', 1, 450, '2022-04-24', NULL, 1), --- maintain
('id5000008', 1, 1500, '2022-04-26', NULL, 1); --- new


--- Update measures
UPDATE DimTaxi_New
SET
Trip_distance = CASE 
						  WHEN t.Trip_duration IS NOT NULL THEN t.Trip_duration * 0.2 
	                      ELSE 0 
	                   END,
	  Fare_amount = CASE 
	                   WHEN t.Trip_duration IS NOT NULL THEN t.trip_duration * 0.05 + 10 
	                   ELSE 0 
	                 END
	FROM DimTaxi_New t
	

-- Update records that already exist in the table
UPDATE DimTaxi
SET Is_current = 0, End_date = GETDATE()
WHERE Id IN ('id0000001', 'id0000008') AND Is_current = 1;


-- Insert records into the table
INSERT INTO DimTaxi (Id, Passenger_count, Trip_distance, Fare_amount, Trip_duration, Effective_date, End_date, Is_current) 
VALUES 
('id5000003', 4, 240, 70, 1200, '2022-04-23', NULL, 1), 
('id5000005', 5, 180, 55, 900, '2022-04-22', NULL, 1), 
('id5000008', 1, 300, 85, 1500, '2022-04-26', NULL, 1),
('id0000001', 2, 120, 40, 600, '2022-04-25', NULL, 1), --- update
('id0000008', 1, 90, 32.5, 450, '2022-04-24', NULL, 1); --- update


-- Update the new records to be current
UPDATE DimTaxi
SET Is_current = 1, End_date = NULL
1.	WHERE Id IN ('id5000003', 'id5000005', 'id5000008');

DROP TABLE DimTaxi_New;
