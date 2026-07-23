-- 1) Display all passenger details.
SELECT *
FROM Passenger;

-- 2) Show only confirmed bookings.
SELECT *
FROM Booking
WHERE Booking_Status = 'Confirmed';

-- 3) Display flights sorted by total seats.
SELECT Flight_Number, Total_Seats
FROM Flight
ORDER BY Total_Seats DESC;

-- 4) Calculate total revenue generated.
SELECT SUM(Total_Fare) AS Total_Revenue
FROM Booking;

-- 5) Count bookings by status.
SELECT Booking_Status,
COUNT(*) AS Total_Bookings
FROM Booking
GROUP BY Booking_Status;

-- 6) Show passenger names with booking details.
SELECT
P.First_Name,
P.Last_Name,
B.Booking_ID,
B.Total_Fare
FROM Passenger P
INNER JOIN Booking B
ON P.Passenger_ID = B.Passenger_ID;

-- 7) Show passenger, flight, and booking details.
SELECT
P.First_Name,
P.Last_Name,
F.Flight_Number,
B.Total_Fare
FROM Passenger P
JOIN Booking B
ON P.Passenger_ID = B.Passenger_ID
JOIN Flight F
ON B.Flight_ID = F.Flight_ID;

-- 8) Show flights with more than 5 bookings.
SELECT
Flight_ID,
COUNT(*) AS Total_Bookings
FROM Booking
GROUP BY Flight_ID
HAVING COUNT(*) > 5;

-- 9) Find passengers who paid above average fare.
SELECT *
FROM Passenger
WHERE Passenger_ID IN
(
    SELECT Passenger_ID
    FROM Booking
    WHERE Total_Fare >
    (
        SELECT AVG(Total_Fare)
        FROM Booking
    )
);

-- 10) Find bookings higher than the passenger's average fare.
SELECT *
FROM Booking B1
WHERE Total_Fare >
(
    SELECT AVG(Total_Fare)
    FROM Booking B2
    WHERE B1.Passenger_ID = B2.Passenger_ID
);

-- 11) Categorize ticket prices.
SELECT
Booking_ID,
Total_Fare,
CASE
    WHEN Total_Fare < 5000 THEN 'Low Fare'
    WHEN Total_Fare BETWEEN 5000 AND 15000 THEN 'Medium Fare'
    ELSE 'High Fare'
END AS Fare_Category
FROM Booking;

-- 12) Extract username from email IDs.
SELECT
Email,
SUBSTRING_INDEX(Email,'@',1) AS Username
FROM Passenger;

-- 13) Display bookings made this year.
SELECT *
FROM Booking
WHERE YEAR(Booking_Date) = YEAR(CURDATE());

-- 14) Rank bookings based on fare amount.
SELECT
Booking_ID,
Total_Fare,
RANK() OVER(ORDER BY Total_Fare DESC) AS Fare_Rank
FROM Booking;

-- 15) Find top 10 highest-paying bookings.
CREATE VIEW FareRanking AS
(
    SELECT
        Booking_ID,
        Total_Fare,
        RANK() OVER(ORDER BY Total_Fare DESC) AS Rnk
    FROM Booking
);
SELECT *
FROM FareRanking
WHERE Rnk <= 10;

-- 16) How many flights each airline operates.
SELECT airline_name, COUNT(flight_id) AS total_flights
FROM airline
JOIN flight
ON airline.airline_id = flight.airline_id
GROUP BY airline_name;

-- 17) How many flights depart from each airport.
SELECT source_airport, COUNT(*) AS TotalFlights
FROM flight
GROUP BY source_airport;

-- 18) How many flights depart from each airport.
SELECT
seat_class,
COUNT(*) AS AvailableSeats
FROM seat
GROUP BY seat_class;
