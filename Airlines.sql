CREATE TABLE AIRLINE(
code    CHAR(3),
name    CHAR,
street  CHAR,
zipcode NUMBER,
country CHAR,
CONSTRAINT AIRLINE_PRIMARY_KEY PRIMARY KEY (code));

CREATE TABLE AIRCRAFTTYPE(
typeID          CHAR,
manufacturer    CHAR,
range           NUMBER,
CONSTRAINT AIRCRAFTTYPE_PRIMARY_KEY PRIMARY KEY (typeID));

CREATE TABLE AIRPORT(
code        CHAR(3),
name        CHAR,
city        CHAR,
country     CHAR,
capacity    CHAR,
CONSTRAINT AIRPORT_PRIMARY_KEY PRIMARY KEY (code));

CREATE TABLE PASSENGER(
passNr  NUMBER,
firstname   CHAR,
lastname    CHAR,
mr_mrs      CHAR,
title       CHAR,
CONSTRAINT PASSENGER_PRIMARY_KEY PRIMARY KEY (passNr));

CREATE TABLE TICKET(
ticketNr    NUMBER,
issued      DATE,
price       NUMBER,
currency    CHAR,
salesOffice CHAR,
CONSTRAINT TICKET_PRIMARY_KEY PRIMARY KEY (ticketNr));

CREATE TABLE AIRCRAFT(
aircraftNr      NUMBER,
internatRegNr   CHAR,
name            CHAR,
serviceEntry    DATE,
airline         CHAR(3),
type            CHAR,
CONSTRAINT AIRCRAFT_PRIMARY_KEY PRIMARY KEY (aircraftNr),

CONSTRAINT FK_Airline
    FOREIGN KEY (airline)
    REFERENCES AIRLINE(code),
    
CONSTRAINT FK_Type
    FOREIGN KEY (type)
    REFERENCES AIRCRAFTTYPE(typeID));
    
CREATE TABLE DISTANCE(
airport1    CHAR(3),
airport2    CHAR(3),
distance    NUMBER,
CONSTRAINT DISTANCE_PRIMARY_KEY PRIMARY KEY (airport1, airport2),

CONSTRAINT FK_airp1
    FOREIGN KEY (airport1)
    REFERENCES AIRPORT(code),
    
CONSTRAINT FK_airp2
    FOREIGN KEY (airport2)
    REFERENCES AIRPORT(code));
    
CREATE TABLE LISTED_FLIGHT(
airlineCode     CHAR(3),
nr              NUMBER,
sceduledDays    CHAR,
depTime         TIMESTAMP,
arrTime         TIMESTAMP,
depAirport      CHAR(3),
arrAirport      CHAR(3),
aircraftType    CHAR,
CONSTRAINT LISTED_FLIGHT_PRIMARY_KEY PRIMARY KEY (airlineCode, nr),

CONSTRAINT listedFlight_FK_airline
    FOREIGN KEY (airlineCode)
    REFERENCES AIRLINE(code),
    
CONSTRAINT listedFlight_FK_depAirp
    FOREIGN KEY (depAirport)
    REFERENCES AIRPORT(code),
    
CONSTRAINT listedFlight_FK_arrAirp
    FOREIGN KEY (arrAirport)
    REFERENCES AIRPORT(code),
    
CONSTRAINT listedFlight_FK_aircraftType
    FOREIGN KEY (aircraftType)
    REFERENCES AIRCRAFTTYPE(typeID));    
    
CREATE TABLE SPECIFIC_FLIGHT(
flightId        CHAR,
airlineCode     CHAR(3),
listedFlight    NUMBER,
aircraft        NUMBER,
flightDate      DATE,
actArrTime      TIMESTAMP,
actDepTime      TIMESTAMP,

CONSTRAINT SPEC_FLIGHT_PRIMARY_KEY PRIMARY KEY (flightId),

CONSTRAINT specFlight_FK_listedFlight
    FOREIGN KEY (airlineCode, listedFlight)
    REFERENCES LISTED_FLIGHT(airlineCode, nr),
    
CONSTRAINT specFlight_FK_aircraft
    FOREIGN KEY (aircraft)
    REFERENCES AIRCRAFT(aircraftNr));
    
CREATE TABLE SEAT(
rowNr           NUMBER,
seatNr          CHAR,
location        CHAR,
aircraftType    CHAR,
class           CHAR,

CONSTRAINT SEAT_PRIMARY_KEY PRIMARY KEY (rowNr, seatNr),

CONSTRAINT seat_FK_aircraftType
    FOREIGN KEY (aircraftType)
    REFERENCES AIRCRAFTTYPE(typeID));
    
CREATE TABLE SPECIFIC_SEAT(
seatId          CHAR,
rowNr           NUMBER,
seatNr          CHAR,
specificFlight  CHAR,
smoking         NUMBER(1),
booked          NUMBER(1),

CONSTRAINT SEC_SEAT_PRIMARY_KEY PRIMARY KEY (seatId),

CONSTRAINT specSeat_FK_seat
    FOREIGN KEY (rowNr, seatNr)
    REFERENCES SEAT(rowNr, seatNr),
    
CONSTRAINT specSeat_FK_specFlight
    FOREIGN KEY (specificFlight)
    REFERENCES SPECIFIC_FLIGHT(flightId));
    
CREATE TABLE BOOKING(
passengerNr     NUMBER,
specificSeat    CHAR,
ticket          NUMBER,

CONSTRAINT BOOKING_PRIMARY_KEY PRIMARY KEY (passengerNr, specificSeat),

CONSTRAINT booking_FK_passenger
    FOREIGN KEY (passengerNr)
    REFERENCES PASSENGER (passNr),
    
CONSTRAINT booking_FK_specSeat
    FOREIGN KEY(specificSeat)
    REFERENCES SPECIFIC_SEAT(seatId),
    
CONSTRAINT booking_FK_ticket
    FOREIGN KEY (ticket)
    REFERENCES TICKET(ticketNr));
    