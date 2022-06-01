
USE master;
GO
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = N'bike_dwh')
BEGIN
    ALTER DATABASE bike_dwh SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE bike_dwh;
END;
GO

CREATE DATABASE bike_dwh
GO
USE bike_dwh
GO


--##Date
-- generated from script, role playing dimension
:r D:\PW\MINI\ROK_3\sem6\Hutrownie_danych_i_Systemy_BI\Scripts\CalendarSetup.sql


CREATE TABLE [Bike_borrows_Fact](
	[ride_id] [nvarchar](16) not null primary key,
	[rideable_type] [nvarchar](50) not null,
	--started_at
	[started_day]  date  not null,
	[started_hour] time not null,

	--ended_at
	[ended_day] date not null,
	[ended_hour] time not null,

	[borrow_tine] float not null,

	--[start_station_name]   [nvarchar](50) not null, 
	[start_station_id] [nvarchar](5) not null,
	--[end_station_name] [nvarchar](50) not null,
	[end_station_id] [nvarchar](5) not null,
	--[start_lat] float not null,
	--[start_lng] float not null, 
	--[end_lat] float not null,
	--[end_lng] float not null,
	[member_casual] [nvarchar](50) not null, 
	[user_id] int not null,
	[user_age] int not null,

	--TEMP
	[TEMP] float not null,
	--DEWP
	[DEWP] float not null,
	--SLP
	[SLP] float not null,
	--STP
	[STP] float not null,
	--VISIB
	[visibility] float not null,
	--WDSP
	[WDSP] float not null,
	--MXSPD
	[MXSPD] float not null,
	--GUST
	[GUST] float not null,
	--MAX
	[MAX_TEMP] float not  null,
	--MIN
	[MIN_TEMP] float not null, 
	--PRCP
	[PRCP] float not null,
	--SNDP
	[SNDP] float not null
	--FRSHTT


)

ALTER TABLE [Bike_borrows_Fact]  WITH CHECK ADD CONSTRAINT [FK__Bike_borrows_Fact_start_day_calendar] FOREIGN KEY([started_day])
REFERENCES [Calendar] (Date)
GO

ALTER TABLE [Bike_borrows_Fact]  WITH CHECK ADD CONSTRAINT [FK__Bike_borrows_Fact_ended_day_calendar] FOREIGN KEY([ended_day])
REFERENCES [Calendar] (Date)
GO

CREATE TABLE [Bike_stations](
	[station_id] [nvarchar](5) not null primary key, 
	[station_name]   [nvarchar](50) not null, 
	[station_latitude] float not null,
	[station_longitude] float not null

)

ALTER TABLE [Bike_borrows_Fact]  WITH CHECK ADD CONSTRAINT [FK__Bike_borrows_start_station] FOREIGN KEY([start_station_id])
REFERENCES [Bike_stations] ([station_id])
GO

ALTER TABLE [Bike_borrows_Fact]  WITH CHECK ADD CONSTRAINT [FK__Bike_borrows_end_station] FOREIGN KEY([end_station_id])
REFERENCES [Bike_stations] ([station_id])
GO


CREATE TABLE [Users](
	[user_id] int not null primary key, 
	[date_of_birth]   date  not null, 
)

ALTER TABLE [Bike_borrows_Fact]  WITH CHECK ADD CONSTRAINT [FK__Bike_borrows_user] FOREIGN KEY([user_id])
REFERENCES [Users] ([user_id])
GO


ALTER TABLE [Users]  WITH CHECK ADD CONSTRAINT [FK__Users_date_of_birth] FOREIGN KEY([date_of_birth])
REFERENCES [Calendar] (Date)
GO

CREATE TABLE [Weather](

	[date] date not null primary key,

	--TEMP
	[TEMP_level] [nvarchar](50) not null,
	--DEWP
	[DEWP_level] [nvarchar](50) not null,
	--SLP
	[SLP_level] [nvarchar](50) not null,
	--STP
	[STP_level] [nvarchar](50) not null,
	--VISIB
	[visibility_level] [nvarchar](50) not null,
	--WDSP
	[WDSP_level] [nvarchar](50) not null,
	--MXSPD
	[MXSPD_leveln] [nvarchar](50) not null,
	--GUST
	[GUST_level] [nvarchar](50) not null,
	--MAX
	[MAX_TEMP_level] [nvarchar](50) not  null,
	--MIN
	[MIN_TEMP_level] [nvarchar](50) not null, 
	--PRCP
	[PRCP_level] [nvarchar](50) not null,
	--SNDP
	[SNDP_level] [nvarchar](50) not null,
	--FRSHTT

	[Fog] BIT not null,
	[Rain_or_Drizzle] BIT not null,
	[Snow_or_Ice_Pellets] BIT not null,
	[Hail] BIT not null,
	[Thunder] BIT not null,
	[Tornado_or_Funnel_Cloud] BIT not null
)

ALTER TABLE [Weather]  WITH CHECK ADD CONSTRAINT [FK__weather_day_calendar] FOREIGN KEY([date])
REFERENCES [Calendar] (Date)
GO

--ALTER TABLE [Weather]  WITH CHECK ADD CONSTRAINT [FK__Bike_borrows_weather_] FOREIGN KEY([date])
--REFERENCES [Bike_borrows_Fact] ([started_day])
--GO

ALTER TABLE [Bike_borrows_Fact]  WITH CHECK ADD CONSTRAINT [FK__Bike_borrows_weather_] FOREIGN KEY([started_day])
REFERENCES [Weather] ([date])
GO





