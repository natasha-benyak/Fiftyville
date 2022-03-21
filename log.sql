-- Keep a log of any SQL queries you execute as you solve the mystery.

-- getting info according to what we know - place and date of the crime
SELECT * FROM crime_scene_reports WHERE street = "Chamberlin Street" AND day = 28;
-- result
Theft of the CS50 duck took place at 10:15am at the Chamberlin Street courthouse.
Interviews were conducted today with three witnesses who were present at the time —
each of their interview transcripts mentions the courthouse.

-- checking interview table to find witnesses
SELECT * FROM interviews WHERE day = 28 AND month = 7;
-- result
Found 3 witnesses
id | year | month | day | street | description

-- 1st 160 | Barbara | 2020 | 7 | 28 | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.
The theif could have a German name

-- 2nd 161 | Ruth | 2020 | 7 | 28 | Sometime within ten minutes of the theft, I saw the thief get into a car in the courthouse parking lot and drive away. If you have security footage from the courthouse parking lot, you might want to look for cars that left the parking lot in that time frame.
-- checking securoty logs as per witness advice
SELECT * FROM courthouse_security_logs WHERE year = 2020 AND day = 28 AND month = 7;
-- getting number plates of the suspects
259 | 2020 | 7 | 28 | 10 | 14 | entrance | 13FNH73
260 | 2020 | 7 | 28 | 10 | 16 | exit | 5P2BI95
261 | 2020 | 7 | 28 | 10 | 18 | exit | 94KL13X
262 | 2020 | 7 | 28 | 10 | 18 | exit | 6P58WS2
263 | 2020 | 7 | 28 | 10 | 19 | exit | 4328GD8
264 | 2020 | 7 | 28 | 10 | 20 | exit | G412CB7
265 | 2020 | 7 | 28 | 10 | 21 | exit | L93JTIZ
266 | 2020 | 7 | 28 | 10 | 23 | exit | 322W7JE
267 | 2020 | 7 | 28 | 10 | 23 | exit | 0NTHK55
268 | 2020 | 7 | 28 | 10 | 35 | exit | 1106N58

-- 3rd 162 | Eugene | 2020 | 7 | 28 | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at the courthouse, I was walking by the ATM on Fifer Street and saw the thief there withdrawing some money.
-- check acocunt numbers from ATM records on Fifer Street
SELECT * FROM atm_transactions WHERE atm_location = "Fifer Street" AND year = 2020 AND month = 7 AND day = 28;

id | account_number | year | month | day | atm_location | transaction_type | amount
246 | 28500762 | 2020 | 7 | 28 | Fifer Street | withdraw | 48
264 | 28296815 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
266 | 76054385 | 2020 | 7 | 28 | Fifer Street | withdraw | 60
267 | 49610011 | 2020 | 7 | 28 | Fifer Street | withdraw | 50
269 | 16153065 | 2020 | 7 | 28 | Fifer Street | withdraw | 80
288 | 25506511 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
313 | 81061156 | 2020 | 7 | 28 | Fifer Street | withdraw | 30
336 | 26013199 | 2020 | 7 | 28 | Fifer Street | withdraw | 35

-- checking each bank account at the time
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 28500762;
-- account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
-- 28500762 | 467400 | 2014 | 467400 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 28296815;
-- 28296815 | 395717 | 2014 | 395717 | Bobby | (826) 555-1652 | 9878712108 | 30G67EN
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 76054385;
-- 76054385 | 449774 | 2015 | 449774 | Madison | (286) 555-6063 | 1988161715 | 1106N58
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 49610011;
-- 49610011 | 686048 | 2010 | 686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 16153065;
-- 16153065 | 458378 | 2012 | 458378 | Roy | (122) 555-4581 | 4408372428 | QX4YZN3
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 25506511;
-- 25506511 | 396669 | 2014 | 396669 | Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 81061156;
-- 81061156 | 438727 | 2018 | 438727 | Victoria | (338) 555-6650 | 9586786673 | 8X428L0
SELECT * FROM bank_accounts JOIN people ON bank_accounts.person_id = people.id WHERE account_number = 26013199;
-- 26013199 | 514354 | 2012 | 514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE

-- 4th 163 | Raymond | 2020 | 7 | 28 | As the thief was leaving the courthouse, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.
-- getting info from phone call log with duration less then 60 sec
SELECT * FROM phone_calls WHERE year = 2020 AND month = 7 AND day = 28 AND duration <= 60;
-- result
-- id | caller | receiver | year | month | day | duration
221 | (130) 555-0289 | (996) 555-8899 | 2020 | 7 | 28 | 51
224 | (499) 555-9472 | (892) 555-8872 | 2020 | 7 | 28 | 36
Ernest 233 | (367) 555-5533 | (375) 555-8161 | 2020 | 7 | 28 | 45
234 | (609) 555-5876 | (389) 555-5198 | 2020 | 7 | 28 | 60
251 | (499) 555-9472 | (717) 555-1342 | 2020 | 7 | 28 | 50
Madison 254 | (286) 555-6063 | (676) 555-6554 | 2020 | 7 | 28 | 43
Russell 255 | (770) 555-1861 | (725) 555-3243 | 2020 | 7 | 28 | 49
261 | (031) 555-6622 | (910) 555-3251 | 2020 | 7 | 28 | 38
279 | (826) 555-1652 | (066) 555-9701 | 2020 | 7 | 28 | 55
281 | (338) 555-6650 | (704) 555-2131 | 2020 | 7 | 28 | 54

Based on the above we have got 3 suspects :
Ernest   233 | (367) 555-5533 | (375) 555-8161 |
Madisson 254 | (286) 555-6063 | (676) 555-6554 |
Russell  255 | (770) 555-1861 | (725) 555-3243 |

-- now checking who each suspect calles at the time
SELECT * FROM people WHERE phone_number = "(375) 555-8161";
Ernest calles Berthold | (375) 555-8161 |  | 4V16VO0
SELECT * FROM people WHERE phone_number = "(676) 555-6554";
Madisson called James | (676) 555-6554 | 2438825627 | Q13SVG6
SELECT * FROM people WHERE phone_number = "(725) 555-3243";
Russell called Philip | (725) 555-3243 | 3391710505 | GW362R6

-- checking flights as per info from a witness
SELECT * FROM airports WHERE city = "Fiftyville";
8 | CSF | Fiftyville Regional Airport | Fiftyville

SELECT * FROM flights JOIN airports ON flights.origin_airport_id = airports.id WHERE year = 2020 AND month = 7 AND day = 29 AND origin_airport_id = 8;
-- id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | id | abbreviation | full_name | city
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
43 | 8 | 1 | 2020 | 7 | 29 | 9 | 30 | 8 | CSF | Fiftyville Regional Airport | Fiftyville

-- checking suspect by passport numbers
Ernest - 5773159633
SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 5773159633;
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
36 | 5773159633 | 4A | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20

Madison - 1988161715
SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 1988161715;
36 | 1988161715 | 6D | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20

Russell - 3592750733
SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 3592750733;
18 | 3592750733 | 4C | 18 | 8 | 6 | 2020 | 7 | 29 | 16 | 0
24 | 3592750733 | 2C | 24 | 7 | 8 | 2020 | 7 | 30 | 16 | 27
54 | 3592750733 | 6C | 54 | 8 | 5 | 2020 | 7 | 30 | 10 | 19

Two suspect left Ernest or Madiosn
-- checking who they called possbile accomis

SELECT * FROM people WHERE name = "Berthold";
864400 | Berthold | (375) 555-8161 |  | 4V16VO0
SELECT * FROM people WHERE name = "James";
250277 | James | (676) 555-6554 | 2438825627 | Q13SVG6
SELECT * FROM people WHERE name = "Philip";
847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6

-- check flights for thief accomplist
Berthold -
SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = "";
-- Berthold had no passpost number provided

James -
SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 2438825627;
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
10 | 2438825627 | 7C | 10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55
21 | 2438825627 | 6A | 21 | 3 | 8 | 2020 | 7 | 26 | 17 | 58
47 | 2438825627 | 9B | 47 | 4 | 8 | 2020 | 7 | 30 | 9 | 46

Philip -
SELECT * FROM passengers JOIN flights ON passengers.flight_id = flights.id WHERE passport_number = 3391710505;
10 | 3391710505 | 2A | 10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55
28 | 3391710505 | 2A | 28 | 3 | 8 | 2020 | 7 | 26 | 22 | 49
47 | 3391710505 | 4D | 47 | 4 | 8 | 2020 | 7 | 30 | 9 | 46

-- find city 4 where they took a flight to
SELECT * FROM flights JOIN airports ON destination_airport_id = airports.id WHERE destination_airport_id = 4;
id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | id | abbreviation | full_name | city
10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55 | 4 | LHR | Heathrow Airport | London
17 | 8 | 4 | 2020 | 7 | 28 | 20 | 16 | 4 | LHR | Heathrow Airport | London
35 | 8 | 4 | 2020 | 7 | 28 | 16 | 16 | 4 | LHR | Heathrow Airport | London
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 4 | LHR | Heathrow Airport | London
55 | 8 | 4 | 2020 | 7 | 26 | 21 | 44 | 4 | LHR | Heathrow Airport | London


Ernest
London
Berthold
