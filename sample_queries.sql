DROP TABLE ImpactedRoute;
DROP TABLE IncidentHandling;
DROP TABLE VehicleOnRoute;
DROP TABLE VehicleOperation;
DROP TABLE RouteSkytrainStation;
DROP TABLE RouteBusStop;
DROP TABLE Tap;
DROP TABLE Skytrain;
DROP TABLE Bus;
DROP TABLE SkytrainStation;
DROP TABLE BusStop;
DROP TABLE SkytrainRoute;
DROP TABLE BusRoute;
DROP TABLE CompassCard;
DROP TABLE FareDiscount;
DROP TABLE Employee;
DROP TABLE EmployeeRole;
DROP TABLE Incident;
DROP TABLE Vehicle;
DROP TABLE Route;
DROP TABLE Stop;

CREATE TABLE Stop (
    stopNumber INT,
    zone INT NOT NULL,
    name VARCHAR(80) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (stopNumber)
);
-- Bus Stops
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (61979, 1, 'UBC Exchange @ Bay 4', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (50386, 1, 'W Broadway @ Alma St', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (50391, 1, 'W Broadway @ Macdonald St', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (50913, 1, 'W Broadway @ Granville St', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (58620, 1, 'Commercial-Broadway Station', 'Active');
-- Skytrain Stations
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (70001, 1, 'Waterfront Station', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (70002, 1, 'Burrard Station', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (70003, 1, 'Granville Station', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (70004, 1, 'Stadium-Chinatown Station', 'Active');
INSERT INTO Stop (stopNumber, zone, name, status) VALUES (70005, 1, 'Main Street-Science World', 'Active');

CREATE TABLE Route (
    routeNumber INT,
    status VARCHAR(20) NOT NULL,
    startStop INT NOT NULL,
    endStop INT NOT NULL,
    PRIMARY KEY (routeNumber),
    FOREIGN KEY (startStop) REFERENCES Stop(stopNumber) ON DELETE CASCADE,
    FOREIGN KEY (endStop) REFERENCES Stop(stopNumber) ON DELETE CASCADE
);

-- Get the average balance for each card type and find the card type(s) with the lowest average balance
SELECT
    c.cardType,
    ROUND(AVG(c.balance), 2) AS avgBalance
FROM CompassCard c
GROUP BY c.cardType
HAVING AVG(c.balance) <= ALL (
    SELECT AVG(c2.balance)
    FROM CompassCard c2
    GROUP BY c2.cardType
)
ORDER BY c.cardType;

-- Get the total number of incidents handled by each employee and find the employee(s) with the highest number of incidents handled
SELECT
    i.incidentID,
    i.startTime,
    i.endTime,
    i.cause,
    i.location
FROM IncidentHandling ih
JOIN Incident i ON ih.incidentID = i.incidentID
WHERE ih.employeeNumber = :id
ORDER BY i.incidentID