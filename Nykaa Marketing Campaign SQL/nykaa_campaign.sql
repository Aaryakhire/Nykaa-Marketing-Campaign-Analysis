use nykaa_campaign_db;

select count(*) 
from nykaa_campaign_data;

select *
from nykaa_campaign_data
limit 10;

# Checking Null Values
SELECT *
FROM nykaa_campaign_data
WHERE Campaign_ID IS NULL
   OR Campaign_Type IS NULL
   OR Target_Audience IS NULL
   OR Duration IS NULL
   OR Channel_Used IS NULL
   OR Impressions IS NULL
   OR Clicks IS NULL
   OR Leads IS NULL
   OR Conversions IS NULL
   OR Revenue IS NULL
   OR Acquisition_Cost IS NULL
   OR ROI IS NULL
   OR Language IS NULL
   OR Engagement_Score IS NULL
   OR Customer_Segment IS NULL
   OR Date IS NULL;
   
#Checking Duplicated campaign id
select count(distinct(campaign_id)) 
from nykaa_campaign_data;

ALTER TABLE nykaa_campaign_data
ADD COLUMN date_new DATE;

SET SQL_SAFE_UPDATES = 0;

UPDATE nykaa_campaign_data
SET date_new = STR_TO_DATE(`Date`, '%d-%m-%Y');

ALTER TABLE nykaa_campaign_data
DROP COLUMN `Date`;

# 1) Top Campaign types by revenue
SELECT Campaign_Type, SUM(Revenue) AS total_revenue
FROM nykaa_campaign_data
GROUP BY Campaign_Type
ORDER BY total_revenue DESC
LIMIT 10;

# 2) Top 10 campaign types by conversions
SELECT Campaign_Type, SUM(Conversions) AS total_conversions
FROM nykaa_campaign_data
GROUP BY Campaign_Type
ORDER BY total_conversions DESC
LIMIT 10;

# 3) Top 10 channels by average ROI
SELECT Channel_Used, AVG(ROI) AS avg_roi
FROM nykaa_campaign_data
GROUP BY Channel_Used
ORDER BY avg_roi DESC
LIMIT 10;
  
# 4) Best target audiences by revenue
SELECT Target_Audience, SUM(Revenue) AS total_revenue
FROM nykaa_campaign_data
GROUP BY Target_Audience
ORDER BY total_revenue DESC;

# 5) Campaigns with highest engagement score
SELECT Campaign_ID, Campaign_Type, Engagement_Score
FROM nykaa_campaign_data
ORDER BY Engagement_Score DESC
LIMIT 10;

# 6) Performance by language
SELECT
    Language,
    SUM(Revenue) AS total_revenue,
    SUM(Conversions) AS total_conversions,
    AVG(Engagement_Score) AS avg_engagement_score
FROM nykaa_campaign_data
GROUP BY Language
ORDER BY total_revenue DESC;

# 7) Performance by customer segment
SELECT
    Customer_Segment,
    SUM(Revenue) AS total_revenue,
    SUM(Conversions) AS total_conversions,
    AVG(ROI) AS avg_roi
FROM nykaa_campaign_data
GROUP BY Customer_Segment
ORDER BY total_revenue DESC;

# 8) Click-through rate by campaign type
SELECT
    Campaign_Type,
    SUM(Clicks) AS total_clicks,
    SUM(Impressions) AS total_impressions,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS ctr_percent
FROM nykaa_campaign_data
GROUP BY Campaign_Type
ORDER BY ctr_percent DESC;

# 9) Conversion rate by channel
SELECT
    Channel_Used,
    SUM(Conversions) AS total_conversions,
    SUM(Clicks) AS total_clicks,
    ROUND(SUM(Conversions) * 100.0 / NULLIF(SUM(Clicks), 0), 2) AS conversion_rate_percent
FROM nykaa_campaign_data
GROUP BY Channel_Used
ORDER BY conversion_rate_percent DESC;






























