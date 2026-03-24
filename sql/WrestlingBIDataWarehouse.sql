--Create WrestlingBI Data Warehouse--
CREATE DATABASE WrestlingBI;

--Upload Match Ratings csv files as flat files--
--Confirm tables are uploaded--
SELECT * FROM dbo.aew_match_ratings;
SELECT * FROM dbo.njpw_match_ratings;
SELECT * FROM dbo.wwe_match_rating;


--Create one combined staging table--
SELECT
    [MatchID],
    [Date],
    [Promotion],
    [Match],
    CageMatchRating,
    CageMatchRatingVotes,
    WONStarRating,
    Opponent1,
    Opponent2
INTO dbo.stg_AllMatches
FROM dbo.aew_match_ratings

UNION ALL

SELECT
    [MatchID],
    [Date],
    [Promotion],
    [Match],
    CageMatchRating,
    CageMatchRatingVotes,
    WONStarRating,
    Opponent1,
    Opponent2
FROM dbo.njpw_match_ratings

UNION ALL

SELECT
    [MatchID],
    [Date],
    [Promotion],
    [Match],
    CageMatchRating,
    CageMatchRatingVotes,
    WONStarRating,
    Opponent1,
    Opponent2
FROM dbo.wwe_match_rating;

--Confirm = 19652 rows--
SELECT COUNT(*) AS TotalRows
FROM dbo.stg_AllMatches;

--Confirm separated by promotion--
SELECT Promotion, COUNT(*) AS MatchCount
FROM dbo.stg_AllMatches
GROUP BY Promotion
ORDER BY Promotion;


--Create DimPromotion--
CREATE TABLE dbo.DimPromotion (
    PromotionKey INT IDENTITY(1,1) PRIMARY KEY,
    PromotionName VARCHAR(20) NOT NULL
);

--Insert the values--
INSERT INTO dbo.DimPromotion (PromotionName)
SELECT DISTINCT Promotion
FROM dbo.stg_AllMatches;

--Confirm--
SELECT * FROM dbo.DimPromotion;


--Create DimDate--
CREATE TABLE dbo.DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    [Year] INT,
    QuarterNumber INT,
    MonthNumber INT,
    MonthName VARCHAR(20),
    DayOfMonth INT,
    DayName VARCHAR(20)
);

--Insert the values--
INSERT INTO dbo.DimDate (
    DateKey,
    FullDate,
    [Year],
    QuarterNumber,
    MonthNumber,
    MonthName,
    DayOfMonth,
    DayName
)
SELECT DISTINCT
    YEAR([Date]) * 10000 + MONTH([Date]) * 100 + DAY([Date]) AS DateKey,
    [Date] AS FullDate,
    YEAR([Date]) AS [Year],
    DATEPART(QUARTER, [Date]) AS QuarterNumber,
    MONTH([Date]) AS MonthNumber,
    DATENAME(MONTH, [Date]) AS MonthName,
    DAY([Date]) AS DayOfMonth,
    DATENAME(WEEKDAY, [Date]) AS DayName
FROM dbo.stg_AllMatches;

--Confirm--
SELECT * FROM dbo.DimDate
ORDER BY FullDate;


--Create FactMatches--
CREATE TABLE dbo.FactMatches (
    FactMatchKey INT IDENTITY(1,1) PRIMARY KEY,
    SourceMatchID VARCHAR(50),
    DateKey INT NOT NULL,
    PromotionKey INT NOT NULL,
    [Match] VARCHAR(MAX),
    Opponent1 VARCHAR(MAX),
    Opponent2 VARCHAR(MAX),
    CageMatchRating DECIMAL(5,2),
    CageMatchRatingVotes INT,
    WONStarRating DECIMAL(4,2)
);

--Insert the values--
INSERT INTO dbo.FactMatches (
    SourceMatchID,
    DateKey,
    PromotionKey,
    [Match],
    Opponent1,
    Opponent2,
    CageMatchRating,
    CageMatchRatingVotes,
    WONStarRating
)
SELECT
    s.MatchID AS SourceMatchID,
    YEAR(s.[Date]) * 10000 + MONTH(s.[Date]) * 100 + DAY(s.[Date]) AS DateKey,
    p.PromotionKey,
    s.[Match],
    s.Opponent1,
    s.Opponent2,
    s.CageMatchRating,
    s.CageMatchRatingVotes,
    s.WONStarRating
FROM dbo.stg_AllMatches s
JOIN dbo.DimPromotion p
    ON s.Promotion = p.PromotionName;


--Add Foreign Keys--
--Add Foreign Key to DimDate--
ALTER TABLE dbo.FactMatches
ADD CONSTRAINT FK_FactMatches_DimDate
FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey);

--Add Foreign Key to DimPromotion--
ALTER TABLE dbo.FactMatches
ADD CONSTRAINT FK_FactMatches_DimPromotion
FOREIGN KEY (PromotionKey) REFERENCES dbo.DimPromotion(PromotionKey);

--Confirm--
Select * From FactMatches
Order By WONStarRating Desc;