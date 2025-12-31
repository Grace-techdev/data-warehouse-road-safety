CREATE TABLE DimAgeGroup (
 "AgeGroupID" INT PRIMARY KEY, 
 "Age Group" VARCHAR(50) NULL
);

CREATE TABLE DimCrashType (
 "CrashTypeID" INT PRIMARY KEY, 
 "Crash Type" VARCHAR(50) NULL
);

CREATE TABLE DimDate (
 "DateID" INT PRIMARY KEY, 
 "Month" INT NOT NULL, 
  "Year" INT NOT NULL,
 "Quarter" INT NOT NULL
);

CREATE TABLE DimDayweek (
 "DayweekID" INT PRIMARY KEY, 
 "Dayweek" VARCHAR(50) NULL
);

CREATE TABLE DimDayofWeek (
 "DayofWeekID" INT PRIMARY KEY, 
 "Day of week" VARCHAR(50) NULL
);

CREATE TABLE DimGender (
 "GenderID" INT PRIMARY KEY, 
 "Gender" VARCHAR(50) NULL
);

CREATE TABLE DimHoliday (
 "HolidayID" INT PRIMARY KEY, 
 "Holiday Status" VARCHAR(50) NULL
);

CREATE TABLE DimInvolvement (
 "InvolvementID" INT PRIMARY KEY, 
 "Involvement Type" VARCHAR(50) NULL
);

CREATE TABLE DimLocation (
 "LocationID" INT PRIMARY KEY, 
 "National LGA Name 2021" VARCHAR(50) NULL, 
 "State" VARCHAR(50) NULL
);

CREATE TABLE DimRoad (
 "RoadID" INT PRIMARY KEY, 
 "National Road Type" VARCHAR(50) NULL
);

CREATE TABLE DimSpeedLimit (
 "SpeedID" INT PRIMARY KEY, 
 "Speed Limit Category" VARCHAR(50) NULL
);

CREATE TABLE DimTime (
 "TimeID" INT PRIMARY KEY, 
 "Time of day" VARCHAR(50) NULL
);

CREATE TABLE DimUser (
 "UserID" INT PRIMARY KEY, 
 "Road User" VARCHAR(50) NULL
);

CREATE TABLE FactFatalities (
 "FatalitiesID" INT PRIMARY KEY, 
 "DateID" INT  NULL, 
 "LocationID" INT  NULL, 
 "DayweekID" INT  NULL, 
 "DayofWeekID" INT  NULL, 
 "HolidayID" INT  NULL, 
 "TimeID" INT  NULL, 
 "CrashTypeID" INT NULL, 
 "UserID" INT  NULL, 
 "RoadID" INT  NULL, 
 "GenderID" INT  NULL, 
 "AgeGroupID" INT  NULL, 
 "SpeedID" INT  NULL, 
 "InvolvementID" INT NULL, 
 "Fatality" INT  NULL, 
 "Fatality Rate per Population LGA" FLOAT NULL, 
 "Fatality Rate per Population State" FLOAT NULL, 
 "Fatality Rate per Dwelling" FLOAT NULL,
 FOREIGN KEY ("DateID") REFERENCES DimDate("DateID"),
 FOREIGN KEY ("DayweekID") REFERENCES DimDayweek("DayweekID"),
 FOREIGN KEY ("DayofWeekID") REFERENCES DimDayofWeek("DayofWeekID"),
 FOREIGN KEY ("HolidayID") REFERENCES DimHoliday("HolidayID"),
 FOREIGN KEY ("TimeID") REFERENCES DimTime("TimeID"),
 FOREIGN KEY ("CrashTypeID") REFERENCES DimCrashType("CrashTypeID"),
 FOREIGN KEY ("UserID") REFERENCES DimUser("UserID"),
 FOREIGN KEY ("RoadID") REFERENCES DimRoad("RoadID"),
 FOREIGN KEY ("GenderID") REFERENCES DimGender("GenderID"),
 FOREIGN KEY ("AgeGroupID") REFERENCES DimAgeGroup("AgeGroupID"),
 FOREIGN KEY ("LocationID") REFERENCES DimLocation("LocationID"),
 FOREIGN KEY ("SpeedID") REFERENCES DimSpeedLimit("SpeedID"),
 FOREIGN KEY ("InvolvementID") REFERENCES DimInvolvement("InvolvementID")
);

COPY DimAgeGroup
FROM '/tmp/DataWarehouse/DimAgeGroup.csv'
WITH CSV HEADER;

COPY DimCrashType
FROM '/tmp/DataWarehouse/DimCrashType.csv'
WITH CSV HEADER;

COPY DimDate
FROM '/tmp/DataWarehouse/DimDate.csv'
WITH CSV HEADER;

COPY DimDayweek
FROM '/tmp/DataWarehouse/DimDayweek.csv'
WITH CSV HEADER;

COPY DimDayofWeek
FROM '/tmp/DataWarehouse/DimDayofWeek.csv'
WITH CSV HEADER;

COPY DimGender
FROM '/tmp/DataWarehouse/DimGender.csv'
WITH CSV HEADER;

COPY DimHoliday
FROM '/tmp/DataWarehouse/DimHoliday.csv'
WITH CSV HEADER;

COPY DimInvolvement
FROM '/tmp/DataWarehouse/DimInvolvement.csv'
WITH CSV HEADER;

COPY DimLocation
FROM '/tmp/DataWarehouse/DimLocation.csv'
WITH CSV HEADER;

COPY DimRoad
FROM '/tmp/DataWarehouse/DimRoad.csv'
WITH CSV HEADER;

COPY DimSpeedLimit
FROM '/tmp/DataWarehouse/DimSpeedLimit.csv'
WITH CSV HEADER;

COPY DimTime
FROM '/tmp/DataWarehouse/DimTime.csv'
WITH CSV HEADER;

COPY DimUser
FROM '/tmp/DataWarehouse/DimUser.csv'
WITH CSV HEADER;

COPY FactFatalities
FROM '/tmp/DataWarehouse/FactFatalities.csv'
WITH CSV HEADER;