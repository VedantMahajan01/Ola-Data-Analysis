Create Database Ola;
Use Ola;
select * from data;
ALTER TABLE data
ALTER COLUMN Ride_Distance FLOAT;

--Retrieve all successful bookings
Create VIEW Successful_Bookings As
SELECT * FROM data
WHERE Booking_Status = 'Success';

select COUNT(Booking_Status) as SuccessBooking_Count from data  WHERE Booking_Status = 'Success';

select * from Successful_Bookings;


--Find the average ride distance for each vehicle type
Create VIEW ride_distance_for_each_vehicle As
SELECT Vehicle_Type, AVG(Ride_Distance)
as avg_distance FROM data
GROUP BY Vehicle_Type;

select * from ride_distance_for_each_vehicle;

--Get the total number of cancelled rides by customers
CREATE VIEW cancelled_rides_by_customers AS
SELECT COUNT(Booking_Status) AS Cancelled_Rides 
FROM data
WHERE Booking_Status = 'Cancelled by Driver';

select * from cancelled_rides_by_customers;

--List the top 5 customers who booked the highest number of rides
CREATE VIEW Top_5_Customers AS
SELECT TOP 5 Customer_ID, COUNT(Booking_ID) AS total_rides
FROM data
GROUP BY Customer_ID
ORDER BY total_rides DESC;

select * from Top_5_Customers;

--Get the number of rides cancelled by drivers due to personal and customer-related issues
CREATE VIEW Rides_cancelled_by_Drivers_P_C_Issues AS
SELECT COUNT(Cancelled_Rides_by_Driver) AS Total_Canceled_Rides
FROM data
WHERE Cancelled_Rides_by_Driver = 'Customer related issue';

select * from Rides_cancelled_by_Drivers_P_C_Issues;


--Find the maximum and minimum driver ratings for Prime Sedan bookings
Create View Max_Min_Driver_Rating As
SELECT MAX(Driver_Ratings) as max_rating,
MIN(Driver_Ratings) as min_rating
FROM data
WHERE Vehicle_Type = 'Prime Sedan';

select * from Max_Min_Driver_Rating;


--Retrieve all rides where payment was made using UPI
Create View UPI_Payment As
SELECT * FROM data
WHERE Payment_Method = 'UPI';

select * from UPI_Payment;
select count(Payment_Method) as UPI_payment from data;


--Find the average customer rating per vehicle type
CREATE VIEW AVG_Cust_Rating AS
SELECT Vehicle_Type, 
    ROUND(AVG(TRY_CAST(Customer_Rating AS FLOAT)), 3) AS avg_customer_rating
FROM data
WHERE 
    TRY_CAST(Customer_Rating AS FLOAT) IS NOT NULL
GROUP BY Vehicle_Type;

select * from AVG_Cust_Rating;


--Calculate the total booking value of rides completed successfully
Create View total_successful_ride_value As
SELECT Count(Booking_Value) as total_successful_ride_value
FROM data
WHERE Booking_Status = 'Success';

SELECT 
    SUM(CAST(Booking_Value AS DECIMAL(10, 2))) AS total_successful_ride_value
FROM data
WHERE Booking_Status = 'Success';

select * from total_successful_ride_value;


--List all incomplete rides along with the reason
Create View Incomplete_Rides_Reason As
SELECT Booking_ID, Incomplete_Rides_Reason
FROM data
WHERE Incomplete_Rides = 'YES';

select * from Incomplete_Rides_Reason;