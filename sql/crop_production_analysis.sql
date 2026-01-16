create database analytics_project

use analytics_project

select Top 10 *
from crop_production


SELECT DISTINCT State_Name
FROM crop_production



SELECT COUNT(DISTINCT State_Name) AS number_of_states
FROM crop_production


SELECT 
    State_Name,
    SUM(Production) AS Total_Production
FROM crop_production
GROUP BY State_Name
ORDER BY Total_Production DESC;

-------top 10 states with higest production--------

SELECT TOP 10
    State_Name,
    SUM(Production) AS Total_Production
FROM crop_production
GROUP BY State_Name
ORDER BY Total_Production DESC;

---------Top crops in each region (state)---------------

SELECT
    State_Name,
    Crop,
    SUM(Production) AS Total_Production
FROM crop_production
GROUP BY State_Name, Crop;

-------------------------------------------
WITH crop_totals AS (
    SELECT
        State_Name,
        Crop,
        SUM(Production) AS Total_Production
    FROM crop_production
    GROUP BY State_Name, Crop
)
SELECT
    State_Name,
    Crop,
    Total_Production
FROM (
    SELECT
        State_Name,
        Crop,
        Total_Production,
        RANK() OVER (
            PARTITION BY State_Name
            ORDER BY Total_Production DESC
        ) AS crop_rank
    FROM crop_totals
) ranked
WHERE crop_rank = 1
ORDER BY State_Name;


---------------------How production varies by season--------------------

SELECT
    Season,
    SUM(Production) AS Total_Production
FROM crop_production
GROUP BY Season
ORDER BY Total_Production DESC;

--------------------How has crop production evolved over the years?---------
SELECT
    Crop_Year,
    SUM(Production) AS Total_Production
FROM crop_production
GROUP BY Crop_Year
ORDER BY Crop_Year;


----------------How has crop production evolved over the years?--------------------
SELECT
    State_Name,
    Crop,
    SUM(Production) / NULLIF(SUM(Area), 0) AS Yield
FROM crop_production
GROUP BY State_Name, Crop
ORDER BY Yield DESC;


---------------------------------How does production vary seasonally across the years?-----------



SELECT
    Crop_Year,
    Season,
    SUM(Production) AS Total_Production
FROM crop_production
GROUP BY Crop_Year, Season
ORDER BY Crop_Year, Season;




