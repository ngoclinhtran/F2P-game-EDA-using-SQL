# Exploratory Data Analytics (EDA) on data of a free-to-play game using SQL queries and Microsoft Power BI

## Context of Data
- This is a data of a mobile free-to-play casual puzzle game
- The data period is from 20th of May, 2017 to 18th of June, 2017
- The data period contains an in-game event which ran from 12th of June to 15th of June

## Objectives of EDA
The EDA was performed in the dataset to estimate the impact of the in-game event, find the best insights from the data, and share the insights via data visualization. This project's objectives is to learn more about the game industry and the KPIs of the industry, advanced SQL queries writing, especially to practice writing complex queries, improve data analytics and data visualization skills, and develop the ability to tell stories from data.

## KPIs using in this project
- **DAU (Daily Active Users)**: the number of unique users who were active in the game on a given day.
- **Revenue**: the total sum of revenue in dollars that was generated on a given day.
- **ARPDAU (Average revenue per daily active user)**: the total sum of revenue divided by the number of unique users active on that day. This KPI gives a rough estimate of how valuable users are and how trend of revenue related to the trend of active users.
- **Conversion rate**: the percentage of users who have purchased anything that day out of all active users.
- **ARPPU (Average revenue per paying user)**: the average revenue per user who spent something that day.
- **Paying DAU**: the number of unique users who have spent in their lifetime, not necessarily on a given day.
- **Installs**: the number of users who installed the game on a given day.
- **Levels played**: mean and percentiles of how many levels users played in a given timeframe (in this project, this KPI will be displayed overtime and per specific period of time -eg before, during, and after the event)

## Tasks for the project
This project used SQL queries to manipulate the data and Microsoft Power BI to visualize the data. The project was divided into 2 parts: 1. perform EDA in the data based on the KPIs of the industry, 2. based on the data, create user segmentation for sales and events in the most targeted and personalized manner, calculate the target for future in-game event, and estimate the target completion rate.

**1. EDA and KPIs analytics** (The result can be found in the 'Presentation for EDA and Insights.pdf' file)
- Perform EDA for an overview of the data, review data at the first glance
- Retrieve data and creating charts showing Activity KPIs (DAU, Installs, Levels played), how they change during the in-game event, what trends could be spotted out of the charts, why those KPIs were affected that way, and find insights related to those. Think about the suggestion for better future in-game events.
- Retrieve data and creating charts showing Revenue KPIs (Revenue, ARPDAU, ARPPU, Conversion rate), how they change during the in-game event, what trends could be spotted out of the charts, why those KPIs were affected that way, and find insights related to those. Think about the suggestion for better future in-game events.
- To understand how the event connected with the audiences, this project looked at 2 parameters: "age" (days since installation), and "lifetime revenue" (how much revenue they generated since becoming a player. Bucket the categories of "age" and "lifetime revenue" in order to visualize data in a best way. Find insight from these two parameters, which group should the game offer sales, should the game target specific groups for harder/easier events.

**2. Create user segmentation, calculate the target for future in-game event, and estimate the target completion rate** (The result can be found in the 'Presentation for User Segmentation and Prediction for future event.pdf' file)
- Group users into segments based on levels played. Calculate the percentage of active users will fall into each segment.
- There is a future in-game event that will run on Friday. The goal of this event is to encourage players to play more levels by introducing a personalized level win target. This project used 'Activity lift' (the required target compared to segment's average levels played). The 'Activity lift' should be around 50% higher than segment's average. 
- Calculate the target for each segment.
- Based on the levels users typically play (can be observed and calculated from the data), calculate the target completion rate and calculate the number of users who would reach 50% of the target.

## Notes
- There are 2 pdf files created for the purpose of present the result of 2 parts of this project. Each pdf file is a presentation of the result with insights, graphs and charts for data visualzation, and additional questions. 
- There are 2 sql files, which contain all of the SQL queries used in 2 parts of this project. Each sql file contains queries code and comments to further explain the queries for the readers.
- This is a personal project, which was created for the purpose of learning and assessing personal skills. Any comments, feedbacks are more than welcome.
