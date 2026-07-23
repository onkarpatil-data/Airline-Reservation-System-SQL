CREATE DATABASE AirlineReservationDB;

USE AirlineReservationDB;

-- Passenger Table
CREATE TABLE Passenger (
    Passenger_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender ENUM('Male','Female','Other'),
    DOB DATE,
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Passport_No VARCHAR(20) UNIQUE
);

-- Airport Table
CREATE TABLE Airport (
    Airport_ID INT AUTO_INCREMENT PRIMARY KEY,
    Airport_Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- Airline Table
CREATE TABLE Airline (
    Airline_ID INT AUTO_INCREMENT PRIMARY KEY,
    Airline_Name VARCHAR(100) NOT NULL,
    Contact_No VARCHAR(15)
);

-- Flight Table
CREATE TABLE Flight (
    Flight_ID INT AUTO_INCREMENT PRIMARY KEY,
    Airline_ID INT NOT NULL,
    Flight_Number VARCHAR(20) UNIQUE NOT NULL,
    Source_Airport_ID INT NOT NULL,
    Destination_Airport_ID INT NOT NULL,
    Departure_Time DATETIME NOT NULL,
    Arrival_Time DATETIME NOT NULL,
    Total_Seats INT NOT NULL,
    
    FOREIGN KEY (Airline_ID)
        REFERENCES Airline(Airline_ID),
        
    FOREIGN KEY (Source_Airport_ID)
        REFERENCES Airport(Airport_ID),
        
    FOREIGN KEY (Destination_Airport_ID)
        REFERENCES Airport(Airport_ID)
);

-- Booking Table
CREATE TABLE Booking (
    Booking_ID INT AUTO_INCREMENT PRIMARY KEY,
    Passenger_ID INT NOT NULL,
    Flight_ID INT NOT NULL,
    Booking_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Booking_Status ENUM('Confirmed','Cancelled','Pending') DEFAULT 'Pending',
    Total_Fare DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (Passenger_ID)
        REFERENCES Passenger(Passenger_ID),
        
    FOREIGN KEY (Flight_ID)
        REFERENCES Flight(Flight_ID)
);

-- Seat Table
CREATE TABLE Seat (
    Seat_ID INT AUTO_INCREMENT PRIMARY KEY,
    Flight_ID INT NOT NULL,
    Seat_Number VARCHAR(10) NOT NULL,
    Seat_Class ENUM('Economy','Business','First Class') NOT NULL,
    Availability ENUM('Available','Booked') DEFAULT 'Available',
    
    FOREIGN KEY (Flight_ID)
        REFERENCES Flight(Flight_ID)
);

-- Ticket Table
CREATE TABLE Ticket (
    Ticket_ID INT AUTO_INCREMENT PRIMARY KEY,
    Booking_ID INT NOT NULL,
    Seat_ID INT NOT NULL,
    Ticket_Price DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (Booking_ID)
        REFERENCES Booking(Booking_ID),
        
    FOREIGN KEY (Seat_ID)
        REFERENCES Seat(Seat_ID)
);

-- Payment Table
CREATE TABLE Payment (
    Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Booking_ID INT NOT NULL,
    Payment_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Method ENUM('Credit Card','Debit Card','UPI','Net Banking'),
    Payment_Status ENUM('Success','Failed','Pending') DEFAULT 'Pending',
    
    FOREIGN KEY (Booking_ID)
        REFERENCES Booking(Booking_ID)
);

