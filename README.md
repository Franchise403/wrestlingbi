WrestlingBI

Project Overview:
WrestlingBI is a portfolio project focused on building custom pro wrestling datasets for BI and SQL learning.
The goal of this project is to take something I’m personally interested in and apply real data practices to it — including data collection, cleaning, modeling, and structuring for analysis. While the subject matter is unique, the techniques used (data modeling, ETL concepts, and SQL structure) reflect real-world BI workflows.

Tools Used
Microsoft Excel (Data Cleaning & Preparation)
SQL Server Management Studio (SSMS)

Data Pipeline & Architecture
The project follows a structured pipeline:
1. Raw HTML data collected from source
2. Data cleaned and structured using Excel
3. Exported into multiple CSV datasets
4. Loaded into SQL Server
5. Transformed into a dimensional model
6. Prepared for downstream BI and analysis


Data Sources
This project includes three independently built datasets:
WWE Events & Match Ratings (2015–2025)
NJPW Events & Match Ratings (2015–2025)
AEW Events & Match Ratings (2019–2025)
Full Time Range: January 1, 2015 – December 31, 2025
Source: Data was scraped from Cagematch and transformed into structured datasets
Each dataset includes:
Event-level data
Match-level data
Ratings and supporting metrics
Full data dictionaries

Data Model
The data is structured using a dimensional model designed for analysis:
Fact Table
FactMatches
Stores match-level metrics and ratings
Dimension Tables
DimDate – Date breakdown for time-based analysis
DimPromotion – Identifies promotion (WWE, AEW, NJPW)
Key Design Choices
FactMatchKey used as primary key
DateKey and PromotionKey used for relationships
Star schema structure for simplified querying and reporting

Key Insights (Initial Observations)
(Early-stage — more analysis to come)
Match volume increases across promotions over time, especially after 2019
AEW introduction aligns with increased competition in match output
Ratings distribution varies by promotion, with distinct patterns emerging
Data structure allows for cross-promotion comparison at both event and match level
