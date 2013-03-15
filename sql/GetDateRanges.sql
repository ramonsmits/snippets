create function dbo.GetDateRanges
(
    @type char(1),
    @start datetime,
    @end datetime
)
returns @ranges table(start datetime, finish datetime)
as 
begin
	-- Script that helps in generating a set of datetime values for a range. Useful when you want to use this as a base for (simple) reporting queries in combination with for example left join operations.
	--
	-- Examples:
	-- select * from dbo.GetDateRanges('s','20130101','20130102 00:01:00')
	-- select * from dbo.GetDateRanges('m','20130101','20130101 01:00:00')
	-- select * from dbo.GetDateRanges('h','20130101','20130102')
	-- select * from dbo.GetDateRanges('D','20130101','20140101')
	-- select * from dbo.GetDateRanges('W','20130101','20140101')
	-- select * from dbo.GetDateRanges('M','20130101','20140101')
	-- select * from dbo.GetDateRanges('Q','20130101','20140101')
	-- select * from dbo.GetDateRanges('Y','20130101','20140101')
	
    declare @from datetime = @start
    declare @to datetime = @start

    if @type COLLATE Latin1_General_CS_AS = 's'    		set @to = dateadd(SECOND, 1, @to)
    if @type COLLATE Latin1_General_CS_AS = 'm'    		set @to = dateadd(MINUTE, 1, @to)
    if @type COLLATE Latin1_General_CS_AS = 'h'    		set @to = dateadd(HOUR, 1, @to)
    if @type COLLATE Latin1_General_CS_AS = 'D'    		set @to = dateadd(DAY, 1, @to)
    if @type COLLATE Latin1_General_CS_AS = 'W'    		set @to = dateadd(WEEK, 1, @to)
    if @type COLLATE Latin1_General_CS_AS = 'M'    		set @to = dateadd(MONTH, 1, @to)
    if @type COLLATE Latin1_General_CS_AS = 'Q'    		set @to = dateadd(MONTH, 3, @to)
    if @type COLLATE Latin1_General_CS_AS = 'Y'    		set @to = dateadd(YEAR, 1, @to)

    while @to < @end
    begin 
    	insert @ranges values (@from, @to)
    	set @from = @to 
    	if @type COLLATE Latin1_General_CS_AS = 's'    		set @to = dateadd(SECOND, 1, @to)
    	if @type COLLATE Latin1_General_CS_AS = 'm'    		set @to = dateadd(MINUTE, 1, @to)
    	if @type COLLATE Latin1_General_CS_AS = 'h'    		set @to = dateadd(HOUR, 1, @to)
    	if @type COLLATE Latin1_General_CS_AS = 'D'    		set @to = dateadd(DAY, 1, @to)
    	if @type COLLATE Latin1_General_CS_AS = 'W'    		set @to = dateadd(WEEK, 1, @to)
    	if @type COLLATE Latin1_General_CS_AS = 'M'    		set @to = dateadd(MONTH, 1, @to)
    	if @type COLLATE Latin1_General_CS_AS = 'Q'    		set @to = dateadd(MONTH, 3, @to)
    	if @type COLLATE Latin1_General_CS_AS = 'Y'    		set @to = dateadd(YEAR, 1, @to)
    end

    insert @ranges values (@from, @end)

    return 
end