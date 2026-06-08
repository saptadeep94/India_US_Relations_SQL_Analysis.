-- Data cleaning--
create database india_us_relations;
use india_us_relations;
select * from us_comments_on_india;
alter table us_comments_on_india
add column new_date date;
set sql_safe_updates=0;
update us_comments_on_india
set new_date = str_to_date(date, "%Y-%m-%d");
alter table us_comments_on_india
modify new_date date first;
alter table us_comments_on_india
drop column date;
select * from indian_politicians_comments;
alter table indian_politicians_comments
add column new_date date;
set sql_safe_updates=0;
update indian_politicians_comments
set new_date = str_to_date(date, "%Y-%m-%d");
alter table indian_politicians_comments
modify new_date date first;
alter table indian_politicians_comments
drop column date;
select * from global_comments_on_india_us;
alter table global_comments_on_india_us
add column new_date date;
set sql_safe_updates=0;
update global_comments_on_india_us
set new_date = str_to_date(date, "%Y-%m-%d");
alter table global_comments_on_india_us
modify new_date date first;

 /*QUERIES*/

/*Q1: How did US Presidents' sentiment toward India evolve across eras?
*/
select `presidency era`, sentiment, count(sentiment), round((count(sentiment)*100)/sum(count(sentiment))
OVER (PARTITION BY `presidency era`),1) as percentage
from us_comments_on_india
group by `presidency era`,sentiment;

select * from us_comments_on_india;
select * from global_comments_on_india_us;
select * from indian_politicians_comments;
/*Q2: Which years saw the biggest sentiment swings in bilateral rhetoric?
*/
CREATE VIEW bilateral_sentiment AS
SELECT 'US' as side, YEAR(new_date) as year, sentiment, comment FROM us_comments_on_india
UNION ALL
SELECT 'India' as side, YEAR(new_date) as year, sentiment, comment FROM indian_politicians_comments;

SELECT year, 
       avg(CASE WHEN sentiment='Positive' THEN 3 WHEN sentiment='Neutral' THEN 2 ELSE 1 END) as avg_sentiment_score,
       COUNT(*) as total_comments
FROM bilateral_sentiment 
GROUP BY year HAVING COUNT(*) >= 3 
ORDER BY avg_sentiment_score DESC;

select * from bilateral_sentiment;

/* Q3: Who were the top 5 most vocal US/Indian leaders on relations?
*/
SELECT 'US' as side, `politician name`, COUNT(*) as comments
FROM us_comments_on_india GROUP BY `politician name`
UNION ALL
SELECT 'India' as side, `politician name`, COUNT(*) as comments
FROM indian_politicians_comments GROUP BY `politician name`
ORDER BY comments DESC LIMIT 5;

/* Q4: Did Indian leaders mirror US sentiment during tariff disputes (2018, 2025)?
*/
SELECT uc.new_date, uc.sentiment as us_sentiment, ic.sentiment as india_sentiment
FROM us_comments_on_india uc LEFT JOIN indian_politicians_comments ic ON YEAR(uc.new_date)=YEAR(ic.new_date)
WHERE YEAR(uc.new_date) IN (2018, 2025) AND uc.sentiment='Negative';

/* Q5: How did China/Pakistan/Russia react to India-US highs (e.g., 2023 State Visit)?
*/
SELECT country, sentiment, COUNT(*) as reactions
FROM global_comments_on_india_us 
 GROUP BY 1,2 ORDER BY reactions DESC;

/*Q8: Cross-country comparison: Did global positivity toward India-US ties rise post-Quad (2021+)?
*/
SELECT country, AVG(CASE sentiment WHEN 'Positive' THEN 3 WHEN 'Neutral' THEN 2 ELSE 1 END) as avg_score,
       MIN(new_date) as first_comment
FROM global_comments_on_india_us  WHERE YEAR(new_date) >= 2021 GROUP BY country;

/* Q9: Opposition vs. Government sentiment gap in India (e.g., Rahul Gandhi vs. Modi)?
*/
SELECT sentiment, COUNT(*), `politician name`
FROM  indian_politicians_comments
WHERE `politician name`= 'Narendra Modi'or `politician name`='Rahul Gandhi' or `politician name`='S. Jaishankar'
GROUP BY `politician name`, sentiment 
order BY COUNT(*) DESC;
show tables;

