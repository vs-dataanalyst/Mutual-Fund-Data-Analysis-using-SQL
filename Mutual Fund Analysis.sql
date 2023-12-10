MUTUAL FUND DATA EXPLORATION AND ANALYSIS

-- create database 
   CREATE DATABASE mutual_fund;
   
-- To select database 
   USE mutual_fund;
   
-- Steps to import csv files:
-- 1. Right click on the created database, select Table data import Wizard
-- 2. Browse and select the file path then do next till last step, it will import data.

-- Rename the table mutual_fund_details to MF_scheme_data as there are two tables with similar names.
   RENAME TABLE mutual_fund_details TO MF_scheme_data;

-- To view the data from tables use select * 
   SELECT * FROM MF_scheme_data;
   
-- To check the datatype, Null, Key details of columns
SELECT
   COLUMN_NAME as Field,
   CONCAT (DATA_TYPE,"(",coalesce(character_maximum_length," "),")") as Type,
   is_nullable as 'Null',
   column_key as 'Key'
   FROM information_schema.columns
   WHERE table_name = 'MF_SCHEME_DATA';
   
-- change data type of returns_5yr column double from text in Returns table
   ALTER TABLE RETURNS MODIFY returns_5yr double;   
   
-- To check for duplicates in MID column   
   SELECT MID,COUNT(MID) as id_count FROM mf_scheme_data
   GROUP BY MID
   ORDER BY id_count DESC;

-- To update MID as primary key
   Alter table mf_scheme_data modify column MID int primary key;

-- Replace Blank values with zero in returns_5yr column in Returns table
   UPDATE returns SET returns_5yr=0 
   WHERE returns_5yr = '';

-- Add column risk_level_description in risk_ratio table 
   ALTER TABLE risk_ratio ADD COLUMN risk_level_desc varchar(20);
   

-- Insert description as per the risk levels in risk_level_desc column
update risk_ratio set risk_level_desc =
 case 
    when risk_level = 1 then 'Low risk'
    when risk_level = 2 then 'Low to moderate'
    when risk_level = 3 then 'Moderate'
    when risk_level = 4 then 'Moderately High'
    when risk_level = 5 then 'High' 
    when risk_level = 6 then 'Very High' 
end ;

-- Calculate average returns and add new column in returns table

  ALTER TABLE RETURNS ADD COLUMN average_returns double;
  UPDATE RETURNS SET average_returns = ROUND((returns_1yr+returns_3yr+returns_5yr)/3,2) ;

  
-- Q1. How many mutual fund schemes are there under each AMC, order the schemes with highest count at top?   
 
select amc_name as AMC ,count(scheme_name) as Total_Schemes from mf_scheme_data
group by amc_name
order by Total_Schemes desc;

-- Q2. How many subcategories are present in each category?
select Category,count(sub_category) as Subcategory_count from mf_scheme_data
group by Category
order by Category;

-- Q3. Which Scheme has highest returns in first year?

SELECT T1.scheme_name,T2.returns_1yr from mf_scheme_data as T1 LEFT JOIN returns AS T2
ON T1.MID=T2.MID
ORDER BY returns_1yr DESC LIMIT 1;

-- Q4. Fund Manager with highest returns in five years for each AMC.

SELECT Amc_name,Fund_manager,Returns_5yr FROM 
(SELECT T1.Amc_name,T2.Fund_manager,T3.Returns_5yr,
DENSE_RANK() OVER ( PARTITION BY T1.amc_name ORDER BY T3.Returns_5yr DESC) AS d_rank
FROM mf_scheme_data AS T1 
JOIN fund_details AS T2 ON T1.mid=T2.mid 
JOIN returns AS T3 ON t2.mid=t3.mid) a
WHERE a.d_rank=1 AND returns_5yr != 0;

-- Note: I have taken returns 5yr not equal to zero bcz those are blank values which i have replaced earlier.

-- Q5. Give the details of schemes based on risk level enter by user?

DELIMITER //
CREATE PROCEDURE Risk_measure(IN risk_var INT)
BEGIN 
SELECT T1.* FROM mf_scheme_data as T1 JOIN risk_ratio as T2 ON T1.MID=T2.MID
WHERE Risk_Level = risk_var;
END //
DELIMITER ;

CALL Risk_measure(3);

-- Note: Risk level: (1- Low risk, 2- Low to moderate, 3- Moderate, 4- Moderately High, 5- High, 6- Very High)

-- Q6. Which schemes have fund size between 10000cr to 20000cr? 

SELECT T2.scheme_name,T1.fund_size_cr  FROM Fund_details AS T1 INNER JOIN mf_scheme_data AS T2 ON T1.MID=T2.MID
WHERE T1.FUND_SIZE_CR BETWEEN 10000 AND 20000
ORDER BY T1.FUND_SIZE_CR DESC;

-- Q7. Which schemes have top 10 alpha ratio ?

SELECT T1.scheme_name, T2.alpha FROM mf_scheme_data AS T1 JOIN risk_ratio AS T2
ON T1.MID=T2.MID
ORDER BY alpha DESC 
LIMIT 10;

-- Q8 Create view which includes Scheme name, fund manager , average returns, risk level for equity and debt category.

CREATE VIEW RisknReturn AS 
SELECT T1.Scheme_name,T1.category,T2.Fund_manager,T3.Average_returns,T4.risk_level_desc
FROM mf_scheme_data as T1 JOIN fund_details as T2 USING (MID)
JOIN returns as T3 USING (MID) 
JOIN risk_ratio  as T4 USING (MID)
WHERE T1.category IN ('Equity','Debt');

SELECT * FROM RisknReturn;

-- Q9. Find the scheme details where sub category contains Large.

SELECT * FROM mf_scheme_data 
WHERE sub_category LIKE '%Large%';

-- Q10. Suggest any 3 schemes for client who is risk averse investor and want to start sip amount of 1000 with high rating.

select T1.*,T2.risk_level_desc from mf_scheme_data as T1 join risk_ratio as T2 using (MID)
where T1.min_sip = 1000 AND T2.risk_level_desc='Low Risk'
order by T1.rating desc limit 3;

-- Q11. Average fund size where sharpe ratio is less than equal to 1

SELECT t4.sharpe,t1.scheme_name,t2.fund_size_cr,
avg(fund_size_cr) over () as average_fund_size
FROM mf_scheme_data as T1 JOIN fund_details as T2 USING (MID)
JOIN returns as T3 USING (MID) 
JOIN risk_ratio  as T4 USING (MID)
where t4.sharpe<=1.0
order by sharpe desc;

--Q12 Average fund size where sharpe ratio is greater than equal to 2

SELECT t4.sharpe,t1.scheme_name,t2.fund_size_cr,
avg(fund_size_cr) over () as averagefund_size
FROM mf_scheme_data as T1 JOIN fund_details as T2 USING (MID)
JOIN returns as T3 USING (MID) 
JOIN risk_ratio  as T4 USING (MID)
where t4.sharpe>=2.0
order by sharpe desc;










   
   
   
   
