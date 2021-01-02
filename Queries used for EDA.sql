/*Number of records in the data*/
SELECT COUNT(dbo.Assignment.id) AS number_of_records
FROM dbo.Assignment;

/*Number of unique users active in the data*/
SELECT COUNT(DISTINCT dbo.Assignment.id) AS unique_users
FROM dbo.Assignment;

/* I used this to make sure in 1 day, 1 id only appear 1 time and the answer is yes*/
SELECT id, date, COUNT(*)
FROM dbo.Assignment
GROUP BY date, id
Having COUNT(*) > 1;

/*Revenue and DAU(Daily Active Users) each day during data period (Revenue number was rounded up to 2 digits after decimal point)*/
SELECT date,
	COUNT(DISTINCT dbo.Assignment.id) AS DAU,
	ROUND(SUM(dbo.Assignment.revenue_that_day),2) AS Revenue
FROM dbo.Assignment
GROUP BY date;

/* Paying DAU: number of unique users who have spent in their lifetime, not necessarily on a given day*/
SELECT date,
	COUNT(DISTINCT dbo.Assignment.id) AS Paying_DAU
FROM dbo.Assignment
WHERE dbo.Assignment.id IN (
			SELECT DISTINCT dbo.Assignment.id
			FROM dbo.Assignment
			WHERE revenue_that_day>0)
GROUP BY date
ORDER BY date;

/*Mean of Levels Played per day in three periods: Before Event, During Event, After Event*/
SELECT subquery.time_frame,
	SUM(subquery.levels_played) AS sum_levels_played,
	COUNT(DISTINCT subquery.id) AS number_of_users,
	ROUND(CAST(SUM(subquery.levels_played) AS float)/CAST(COUNT(subquery.id) AS float),2) AS Mean
FROM (
	SELECT dbo.Assignment.levels_played,
		dbo.Assignment.id,
	CASE
		WHEN dbo.Assignment.date < '2017-06-12' THEN 'Before Event'
		WHEN dbo.Assignment.date >= '2017-06-12' AND dbo.Assignment.date <= '2017-06-15' THEN 'During Event'
		ELSE 'After Event'
	END AS time_frame
	FROM dbo.Assignment) AS subquery
GROUP BY time_frame;

/*Mean and Percentile of Levels Played on a given day over time*/
SELECT date,
	SUM(dbo.Assignment.levels_played) AS sum_levels_played,
	COUNT(Distinct dbo.Assignment.id) AS number_of_users,
	ROUND(Cast(SUM(dbo.Assignment.levels_played)as float) / COUNT(DISTINCT dbo.Assignment.id),2) AS mean,
	ROUND(PERCENT_RANK() OVER (ORDER BY SUM(dbo.Assignment.levels_played)),2) AS percentile_rank
FROM dbo.Assignment
GROUP BY date
ORDER BY sum_levels_played;

/*Installs: Number of users installed the game on a given day*/
SELECT date,
	COUNT(dbo.Assignment.id) AS Installs
FROM dbo.Assignment
WHERE dbo.Assignment.days_since_installation = 0
GROUP BY date;

/* ARPDAU (average revenue per daily active user), ARPDAU were rounded up to 3 digits after decimal point */
SELECT date,
	ROUND(SUM(dbo.Assignment.revenue_that_day)/ COUNT( dbo.Assignment.id),3) AS ARPDAU
FROM dbo.Assignment
GROUP BY date
ORDER BY date;

/* Conversion rate (%) of users who have purchased anything that day out of all active users before event, the numbers were rounded up to 2 digits after decimal point*/
SELECT dbo.Assignment.date,
	ROUND(CAST(COUNT(CASE WHEN dbo.Assignment.revenue_that_day > 0 THEN 1 END) AS float) *100 / CAST(COUNT(DISTINCT dbo.Assignment.id) AS float),2) AS 'Conversion%'
FROM dbo.Assignment
GROUP BY dbo.Assignment.date
ORDER BY date;

/* ARPPU Average Revenue Per Paying User: average revenue per user who spent something on that, the numbers were rounded up to 2 digits after decimal point*/
SELECT date,
	ROUND(SUM(dbo.Assignment.revenue_that_day) / COUNT(CASE WHEN dbo.Assignment.revenue_that_day > 0 THEN 1 END),2) AS ARPPU
FROM dbo.Assignment
GROUP BY date
ORDER BY date;

/*The days since installation (Age) of each user, their lifetime revenue, the total levels they played*/
SELECT dbo.Assignment.id, 
	SUM(dbo.Assignment.revenue_that_day) AS lifetime_revenue,
	MAX(dbo.Assignment.days_since_installation) AS Age,
	SUM(dbo.Assignment.levels_played) AS levels_played
FROM dbo.Assignment
GROUP BY id;

/*lifetime revenue, lifetime revenue per user, levels played, levels played per user categorized by 5 different Age Groups: 0-50, 51-100, 101-150, 151-200, >200*/
SELECT subquery.group_age,
	ROUND(SUM(subquery.lifetime_revenue),2) AS group_lifetime_revenue,
	COUNT(subquery.id) AS number_of_users,
	ROUND(SUM(subquery.lifetime_revenue) / COUNT(subquery.id),2) AS lifetime_revenue_per_user,
	SUM(subquery.levels_played) AS levels_played,
	ROUND(CAST(SUM(subquery.levels_played) AS float)/COUNT(subquery.id),2) AS levels_played_per_user
FROM (
	SELECT dbo.Assignment.id,
		SUM(dbo.Assignment.revenue_that_day) AS lifetime_revenue,
		MAX(dbo.Assignment.days_since_installation) AS Age,
		SUM(dbo.Assignment.levels_played) AS levels_played,
		CASE
			WHEN MAX(dbo.Assignment.days_since_installation) <= 50 THEN '0-50'
			WHEN 51 <= MAX(dbo.Assignment.days_since_installation) AND MAX(dbo.Assignment.days_since_installation) <= 100 THEN '51-100'
			WHEN 101 <= MAX(dbo.Assignment.days_since_installation) AND MAX(dbo.Assignment.days_since_installation) <= 150 THEN '101-150'
			WHEN 151 <= MAX(dbo.Assignment.days_since_installation) AND MAX(dbo.Assignment.days_since_installation) <= 200 THEN '151-200'
			ELSE '>200'
		END AS group_age
FROM dbo.Assignment
GROUP BY id) AS subquery
GROUP BY subquery.group_age;




