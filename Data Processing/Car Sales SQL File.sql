
---------Checking for the earliest AND the latest years------------------------------------------------------
Select Min(Year) earliest_year,
       Max(Year) AS Latest_year
From `workspace`.`casestudies`.`bright_car_sale`;
-------------------------------------------------------------------------------------------------------------
Select Make, Count(Year) AS number_of_years,
       Sum(Sellingprice) AS Total_Revenue
From `workspace`.`casestudies`.`bright_car_sale`
Group By Make
Order by Make Desc;
------------------------------------------------------------------------------------------------------------


---Creating of table and selecting the columns and removing of nulls----------------------------------------
Select Year,
  (2025 - TRY_CAST(year AS INT)) AS vehicle_age_years, 
  Count(*) As Number_of_Sales,
  IFNULL(NULLIF(INITCAP(TRIM(Make)), ''), 'No_Maker') AS Make,
  IFNULL(NULLIF(INITCAP(TRIM(Model)), ''), 'No_Model') AS Model,
  IFNULL(NULLIF(TRIM(Trim), ''), 'No_Trim') AS Trim,
  IFNULL(NULLIF(INITCAP(TRIM(Body)), ''), 'No_Body') AS Body,
  IFNULL(NULLIF(LOWER(TRIM(Transmission)), ''), 'No_Transmission') AS Transmission,
  IFNULL(NULLIF(UPPER(TRIM(Vin)), ''), 'No_Vin') AS Vin,
  IFNULL(NULLIF(UPPER(TRIM(State)), ''), 'No_State') AS State,
  IFNULL(NULLIF(INITCAP(TRIM(Color)), ''), 'No_Color') AS Color,
  IFNULL(NULLIF(TRIM(Seller), ''), 'No_Seller') AS Seller_Name,
  IFNULL(NULLIF(INITCAP(TRIM(Interior)), ''), 'No_Interior') AS Interior,
------Dealing with the Odometer table---------------------------------------------------------------------------
  IFNULL(TRY_CAST(REPLACE(Odometer, ',', '') AS INT),0) AS odometer,
      CASE
        WHEN odometer <  20000  THEN 'Low (0–20K)'
        WHEN odometer <  60000  THEN 'Medium (20–60K)'
        WHEN odometer < 120000  THEN 'High (60–120K)'
        ELSE 'Very High (120K+)'
    END AS Mileage_band,
------------Replacing Nulls and creating a Case for the Condition-----------------------------------------------
    IFNULL(TRY_CAST(Condition AS DECIMAL(5,1)),0) AS Condition_score,
    CASE
        WHEN Condition_score <= '10'   THEN 'Poor'
        WHEN Condition_score <= '20'   THEN 'Fair'
        WHEN Condition_score <= '35'    THEN 'Good'
      ELSE 'Excellent'
    END AS condition_tier,
-------- Total Revenue, Profits and the Margins Percentage------------------------------------------------------
    
    IFNULL(TRY_CAST(REPLACE(REPLACE(Mmr,',',''),'$','') AS DECIMAL(12,0)),0)          AS Cost_Price,
    IFNULL(TRY_CAST(REPLACE(REPLACE(Sellingprice,',',''),'$','') AS DECIMAL(12,0)),0)  AS Selling_Price,
    (Selling_Price * Number_of_Sales ) AS Total_Revenue,
    (Selling_price - Cost_price ) AS total_profits,
    ROUND((Sellingprice - Mmr) / NULLIF(Sellingprice, 0) * 100,2) AS Profit_margin_percentage,

   -- Margin tier CASE
    CASE
        WHEN Profit_margin_percentage >  20 THEN 'High Margin'
        WHEN Profit_margin_percentage>  10 THEN 'Medium Margin'
        WHEN Profit_margin_percentage >   0 THEN 'Low Margin'
        WHEN Profit_margin_percentage <=  0 THEN 'Loss'
        ELSE 'Unknown'
    END AS margin_tier,
-------Determining the Sale date, Day, Quarter, Month of the Sale following by the Cases--------------------------------------------------
        Substring(Sale_date,5,11) As Date_of_Sale,
        Substring(Sale_date, 1,3) As Day_of_Sale,
        SUBSTRING(Sale_date, 5,3) AS sale_month_abbr,
        Substring(Sale_date,12,4) AS Year_of_Sale,
        Substring(Sale_date,17,8) AS Time_of_Sale,

      Case
        WHEN Substring(Sale_date, 5, 3) IN ('Jan','Feb','Mar') THEN 'Q1'
        WHEN SUBSTRING(Sale_date, 5, 3) IN ('Apr','May','Jun') THEN 'Q2'
        WHEN SUBSTRING(Sale_date, 5, 3) IN ('Jul','Aug','Sep') THEN 'Q3'
        WHEN SUBSTRING(Sale_date, 5, 3) IN ('Oct','Nov','Dec') THEN 'Q4'
      ELSE 'Unknown'
    END AS sale_quarter,

---- Weekend/Weekday CASE
    CASE Day_of_Sale
        WHEN 'Sat' THEN 'Weekend'
        WHEN 'Sun' THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

---Creating sale time segments for the selling of cars
    CASE
        WHEN Time_of_Sale BETWEEN '00:00:00' AND '05:59:59' THEN 'Late Night'
        WHEN Time_of_Sale BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN Time_of_Sale BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN Time_of_Sale BETWEEN '16:00:00' AND '20:59:59' THEN 'Evening'
      ELSE 'Night'
    END AS sale_time_segment
From `workspace`.`casestudies`.`bright_car_sales`
WHERE vin IS NOT NULL                                                                       -- Remove null VINs
  AND sEllingprice IS NOT NULL                                                              -- Remove null prices
  AND vin NOT IN (SELECT vin FROM `workspace`.`casestudies`.`bright_car_sales`    
      GROUP BY vin HAVING COUNT(*) > 1)                                                     -- Remove duplicate VINs   
      Group By Make,Model,Year, State, trim, body, vin, color, interior, transmission,Seller, 
               Odometer, Condition, Mmr, Sellingprice, Sale_date;
