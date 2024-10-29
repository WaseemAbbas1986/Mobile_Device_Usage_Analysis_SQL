use mobile_usage;
select * from data;

#Count By Device Model
select device_model, count(device_Model)
from data
group by device_model
order by count(device_Model) desc;

# Count By Opearting sysytem
select operating_System, count(operating_System)
from data
group by operating_System
order by count(operating_System) desc;

# Count By Gender
select Gender, count(Gender)
from data
group by Gender
order by count(Gender) desc;

# Average Usage, Screen time and battery drain by device Model
SELECT device_Model, avg(COALESCE(`App_Usage_Time_(min/day)`, 0)) AS Avg_usage_Min,
round(avg(COALESCE(`Screen_On_Time_(hours/day)`, 0)),2) AS Avg_Scren_Time_hours,
round(avg(COALESCE(`Battery_Drain_(mAh/day)`, 0)),2) AS Avg_Barttery_Mrain_MAH
FROM data
GROUP BY device_Model;

# Most used Operating Syastem
select Operating_System, count(*)
from data 
group by Operating_System;

# Average Age By gender
select Gender, round(avg(Age),0)
from data
group by Gender;

# Average Apps Install and Data Usage by Gender
select Gender, round(avg(COALESCE(`Number_of_Apps_Installed`, 0)),2) as avg_Apps_Installed,
round(avg(COALESCE(`Data_Usage_(MB/day)`, 0)),2)as Avg_data_Used from data
group by Gender;

# Average apps Install by Device Model
select Device_Model, round(avg(coalesce(`Number_of_Apps_Installed`)),0) as avg_apps_installed
from data
group by device_Model;

# Which opearting system Used more Data
select Operating_System, round(avg(`Data_Usage_(MB/day)`),2)
from data
group by Operating_System;

# Most Device model used By gender
select Gender, Device_Model, count(Device_model) Total_Count
from data
group by Gender, Device_Model;

# Age Based Behavior
SELECT CASE 
           WHEN Age BETWEEN 18 AND 24 THEN '18-24'
           WHEN Age BETWEEN 25 AND 34 THEN '25-34'
           WHEN Age BETWEEN 35 AND 44 THEN '35-44'
           WHEN Age BETWEEN 45 AND 54 THEN '45-54'
           ELSE '55+'
       END AS age_group,
       round(AVG(`App_Usage_Time_(min/day)`),2) AS avg_app_usage,
       round(AVG(`Data_Usage_(MB/day)`),2) AS avg_data_usage,
       round(AVG(`Battery_Drain_(mAh/day)`),2) AS avg_battery_drain
FROM data
GROUP BY age_group;

# Identify Heavy Users:
SELECT User_ID,
`Data_Usage_(MB/day)`
FROM data
WHERE `Data_Usage_(MB/day)` > (SELECT AVG(`Data_Usage_(MB/day)`) FROM data) * 2
order by `Data_Usage_(MB/day)` desc ;

# Relationship Between App Usage and Data Usage:
SELECT Device_Model,
       AVG(`App_Usage_Time_(min/day)`) AS avg_app_usage,
       AVG(`Data_Usage_(MB/day)`) AS avg_data_usage
FROM data
GROUP BY Device_Model
order by avg_app_usage,avg_data_usage desc;


