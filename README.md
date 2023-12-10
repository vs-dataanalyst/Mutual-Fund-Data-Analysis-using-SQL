# Mutual Fund Data Analysis
### Mutual Fund Data Exploration and Analysis with SQL (MySQL SERVER).<br>
Mutual funds have become an incredibly popular option for a wide variety of investors. As  they offer automatic diversification, as well as the advantages of professional management, liquidity, and customizability. Mutual fund analysis is essential before investing in any mutual fund scheme. This project is designed to give an overview of the mutual fund schemes and its performance, you can better understand the fund's historical performance and risk it contains. This project includes schemes , category, subcategories, risk ratios , fund size, fund age and fund manager details etc . which are beneficial for potential investors to go through this report to analyse and evaluate a mutual fund scheme and learn the pros and cons of the same. It help the individual for comparing different factors and making decision regarding the investment.
<br>
### Datasets Used  :<br>
I have taken the data from Kaggle then split the single table into four tables for more clarity and understanding. Then I have created a unique id i.e MID for each table to  create relationship between these tables.<br><br>
Mf_scheme_data .csv<br>
Returns.csv<br>
Fund_details.csv<br>
Risk_Ratio.csv<br>

### The database tables consists of the following columns: 

#### Mf_scheme_data table 
MID: Unique ID to create relationship with other tables, Primary key <br>
scheme_name: The name of the mutual fund scheme <br>
min_sip: The minimum amount required for a Systematic Investment Plan (SIP) investment in the fund <br>
min_lumpsum: The minimum amount required for a lump sum investment in the fund <br>
expense_ratio: The expense ratio of the fund <br>
amc_name: The name of the asset management company that manages the fund <br>
Rating rating: The rating of the fund on a scale of 1 to 5, with 1 being the lowest and 5 being the highest <br>
Category: The category to which the mutual fund belongs (e.g. equity, debt, hybrid) <br>
Sub-category : It includes category like Small cap, Large cap, ELSS, etc. <br>

#### Fund_details table
Fund manager: A fund manager is responsible for implementing a fund's investment strategy and managing its trading activities.<br>
fund_size_cr: The size of the fund in crore (10 million) units <br>
Fund age: years since inception of scheme <br>

#### Risk_Ratio table
sortino: The Sortino ratio of the fund, which measures the risk-adjusted return of the fund<br>
alpha: The alpha of the fund, which measures the excess return of the fund compared to its benchmark <br>
Standard deviation: A standard deviation is a number that can be used to show how much the returns of a mutual fund scheme are likely to deviate from its average annual returns.<br>
beta: The beta of the fund, which measures the sensitivity of the fund's returns to the market<br>
sharpe: The Sharpe ratio of the fund, which measures the risk-adjusted return of the fund relative to a risk-free asset<br>
Risk level: The risk level of the fund, categorized as Very High,High, Moderately High, Moderately Low, or Low<br>

#### Returns table
Return_1yr (%): The return percentage of the mutual fund scheme over 1 year.<br>
Return_3yr (%): The return percentage of the mutual fund scheme over 3 year.<br>
Return_5yr (%): The return percentage of the mutual fund scheme over 5year.<br>

## Data Exploration: 

1.	Checked all the details of table such column name, data types and constraints
2.	Created MID column as unique id in all tables for relationship.
3.	Checked for duplicate values in MID column and added primary key constraint to MID.
4.	Rename the table mutual_fund_details to MF_scheme_data as similar table name was present in database.
5.	Replaced blanks in returns_5yr column with zero in Returns table.
6.	Created description column in Risk_Ratio table to describe the risk levels from low to high.
7.	Calculated and added Average Returns column in Returns table.
8.	Modify the datatype of columns wherever required.

## Data Analysis

1. I have analysed total number of schemes present under each AMC ( Asset Management Company), where ICICI Prudential Mutual Fund has the highest number of schemes i.e 56 according to this dataset.
2. There are total 772 subcategories of mutual funds, from which 37% of subcategories are in equity, 34% are Debt, 15% are hybrid, 10% are other and 4% are solution oriented.
3. Bank of India short term income scheme has given the highest returns i.e 28.3 % in first year of its inception
4. Under each AMC I have analysed which are best Fund Managers who have achieved the highest returns in 5 year.
5. The relation between the expense ratio and risk level is directly proportional, as the risk level increases the expense ratio also increases.
6. Schemes which have top 10 alpha values belongs to equity and hybrid category.
   note: ( Alpha is the excess returns relative to market benchmark for a given amount of risk taken by the scheme.)
7. When the sharpe ratio is greater than and equal to 2 the average fund size is 6107cr and when sharpe ratio is less than equal to 1 the average fund size is 3022cr.
   From this we can conclude that when the fund size is bigger, than the chances of good returns are higher.
   








