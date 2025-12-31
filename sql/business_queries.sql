--Q1
SELECT 
  dl."State",
  ROUND(SUM(ft."Fatality Rate per Population State")::numeric / 5.0, 4) AS avg_fatality_rate_per_year
FROM FactFatalities ft
JOIN DimLocation dl 
  ON ft."LocationID" = dl."LocationID"
JOIN DimDate dd 
  ON ft."DateID" = dd."DateID"
WHERE dd."Year" BETWEEN 2020 AND 2024
GROUP BY CUBE(dl."State")
HAVING dl."State" is not null
ORDER BY avg_fatality_rate_per_year DESC
LIMIT 1;

--Q2
--state
SELECT 
  dl."State",
  dg."Gender",
  dt."Time of day",
  SUM(ft."Fatality") AS male_daytime_fatalities
FROM FactFatalities ft
JOIN DimLocation dl 
  ON ft."LocationID" = dl."LocationID"
JOIN DimGender dg 
  ON ft."GenderID" = dg."GenderID"
JOIN DimTime dt 
  ON ft."TimeID" = dt."TimeID"
JOIN DimDate dd 
  ON ft."DateID" = dd."DateID"
WHERE dg."Gender" = 'Male'
  AND dt."Time of day" = 'Day'
  AND dd."Year" BETWEEN 2020 AND 2024
GROUP BY CUBE(dl."State",dg."Gender",dt."Time of day")
HAVING dl."State" IS NOT NULL 
ORDER BY male_daytime_fatalities DESC
LIMIT 1;

--LGA
SELECT 
  dl."National LGA Name 2021" AS lga,
  dg."Gender",
  dt."Time of day",
  SUM(ft."Fatality") AS male_daytime_fatalities
FROM FactFatalities ft
JOIN DimLocation dl 
  ON ft."LocationID" = dl."LocationID"
JOIN DimGender dg 
  ON ft."GenderID" = dg."GenderID"
JOIN DimTime dt 
  ON ft."TimeID" = dt."TimeID"
JOIN DimDate dd 
  ON ft."DateID" = dd."DateID"
WHERE dg."Gender" = 'Male'
  AND dt."Time of day" = 'Day'
  AND dd."Year" BETWEEN 2020 AND 2024
  AND dl."National LGA Name 2021" IS NOT NULL
  AND dl."National LGA Name 2021" != 'Unknown'
GROUP BY CUBE(dl."National LGA Name 2021", dg."Gender", dt."Time of day")
HAVING dl."National LGA Name 2021" IS NOT NULL
ORDER BY male_daytime_fatalities DESC
LIMIT 1;

--Q3
-- National road type
SELECT 
  dl."National LGA Name 2021",
  dr."National Road Type",
  dt."Time of day",
  ROUND(SUM(ft."Fatality Rate per Dwelling")::numeric, 4) AS avg_fatality_rate_per_dwelling
FROM FactFatalities ft
JOIN DimLocation dl 
  ON ft."LocationID" = dl."LocationID"
JOIN DimRoad dr 
  ON ft."RoadID" = dr."RoadID"
JOIN DimTime dt 
  ON ft."TimeID" = dt."TimeID"
JOIN DimDate d 
  ON ft."DateID" = d."DateID"
WHERE d."Year" BETWEEN 2020 AND 2024
GROUP BY CUBE(dl."National LGA Name 2021",dr."National Road Type", dt."Time of day")
HAVING dl."National LGA Name 2021" = 'Unincorporated SA'
	AND dt."Time of day" = 'Day'
	AND dr."National Road Type" IS NOT NULL
ORDER BY avg_fatality_rate_per_dwelling DESC
LIMIT 1;

--Day of the week and Time of day
SELECT 
  dl."National LGA Name 2021",
  ddw."Dayweek",
  dt."Time of day",
  ROUND(SUM(ft."Fatality Rate per Dwelling")::numeric, 4) AS avg_fatality_rate_per_dwelling
FROM FactFatalities ft
JOIN DimLocation dl 
  ON ft."LocationID" = dl."LocationID"
JOIN DimRoad dr 
  ON ft."RoadID" = dr."RoadID"
JOIN DimDayWeek ddw 
  ON ft."DayweekID" = ddw."DayweekID"
JOIN DimTime dt 
  ON ft."TimeID" = dt."TimeID"
JOIN DimDate d 
  ON ft."DateID" = d."DateID"
WHERE d."Year" BETWEEN 2020 AND 2024
GROUP BY CUBE(dl."National LGA Name 2021",ddw."Dayweek", dt."Time of day")
HAVING dl."National LGA Name 2021" = 'Unincorporated SA'
	AND dt."Time of day" = 'Day'
	AND ddw."Dayweek" IS NOT NULL
ORDER BY avg_fatality_rate_per_dwelling DESC
LIMIT 1;

--Q4
SELECT 
  dr."National Road Type",
  du."Road User",
  dag."Age Group",
  SUM(ft."Fatality") AS total_fatalities
FROM FactFatalities ft
JOIN DimUser du 
  ON ft."UserID" = du."UserID"
JOIN DimAgeGroup dag 
  ON ft."AgeGroupID" = dag."AgeGroupID"
JOIN DimRoad dr 
  ON ft."RoadID" = dr."RoadID"
JOIN DimDate d 
  ON ft."DateID" = d."DateID"
WHERE dr."National Road Type" = 'National or State Highway'
  AND d."Year" BETWEEN 2020 AND 2024
 AND du."Road User" IS NOT NULL
GROUP BY CUBE(dr."National Road Type",du."Road User", dag."Age Group")
HAVING dr."National Road Type" IS NOT NULL
ORDER BY total_fatalities DESC
LIMIT 3;


--Q5
SELECT
  du."Road User",
  ds."Speed Limit Category",
  di."Involvement Type",
  SUM(ft."Fatality") AS total_fatalities
FROM FactFatalities ft
JOIN DimUser du
  ON ft."UserID" = du."UserID"
JOIN dimspeedlimit ds
  ON ft."SpeedID" = ds."SpeedID"
JOIN diminvolvement di
  ON ft."InvolvementID" = di."InvolvementID"
JOIN DimDate d
  ON ft."DateID" = d."DateID"
WHERE d."Year" BETWEEN 2020 AND 2024
  AND du."Road User" IS NOT NULL
GROUP BY CUBE(du."Road User",ds."Speed Limit Category",di."Involvement Type")
HAVING du."Road User" IS NOT NULL
  AND ds."Speed Limit Category" IS NOT NULL
  AND di."Involvement Type" IS NOT NULL
ORDER BY total_fatalities DESC
LIMIT 1;
