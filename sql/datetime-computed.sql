--
-- Script that helps in adding a set of computed columns. With these computed columns it is much easier to generate simple
-- report queries based on data range types (year, quarter, month, week, day, hour, minute, second, hour of the day and
-- day of the week).
--
-- Tokens:
--
-- {{column}}	: The column name (datetime, date, time, datetime2 type) used as the source column
-- {{table}}	: The table to add the computed columns to
--
ALTER TABLE {{table}} ADD [_{{column}}minute] AS cast(dateadd(minute,datediff(hour,(0),{{column}}),(0)) as smalldatetime);
ALTER TABLE {{table}} ADD [_{{column}}hour] AS cast(dateadd(hour,datediff(hour,(0),{{column}}),(0)) as smalldatetime);
ALTER TABLE {{table}} ADD [_{{column}}day] AS cast(dateadd(day,datediff(day,(0),{{column}}),(0)) as date);
ALTER TABLE {{table}} ADD [_{{column}}week] AS cast(dateadd(week,datediff(week,(0),{{column}}),(0)) as date);
ALTER TABLE {{table}} ADD [_{{column}}month] AS cast(dateadd(month,datediff(month,(0),{{column}}),(0)) as date);
ALTER TABLE {{table}} ADD [_{{column}}quarter] AS cast(dateadd(quarter,datediff(quarter,(0),{{column}}),(0)) as date);
ALTER TABLE {{table}} ADD [_{{column}}year] AS cast(dateadd(year,datediff(year,(0),{{column}}),(0)) as date);
ALTER TABLE {{table}} ADD [_{{column}}time] AS cast(dateadd(hour,datediff(hour,(0),{{column}}),(0)) as time(0));
ALTER TABLE {{table}} ADD [_{{column}}dw] AS datepart(dw,{{column}});