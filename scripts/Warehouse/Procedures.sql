--city
CREATE OR ALTER PROCEDURE dbo.Load_Dimension_City AS
Begin

    DELETE FROM [dbo].[dimension_city]

    INSERT INTO [dbo].[dimension_city]( [CityKey],[CityId],[City],[StateProvince],[Country] )
    SELECT row_number() OVER(ORDER BY CityId) [CityKey], CityId,City,StateProvince,Country 
    FROM [wwilakehouse].[dbo].[City] c
END
--Date
GO
create OR ALTER procedure [dbo].[load_dimension_date] as
begin
	delete from [dbo].[dimension_date]
	INSERT INTO [dbo].[dimension_date]
			   ([Date]
			   ,[DayNumber]
			   ,[Day]
			   ,[Month]
			   ,[ShortMonth]
			   ,[CalendarMonthNumber]
			   ,[CalendarMonthLabel]
			   ,[CalendarYear]
			   ,[CalendarYearLabel]
			   ,[FiscalMonthNumber]
			   ,[FiscalMonthLabel]
			   ,[FiscalYear]
			   ,[FiscalYearLabel]
			   ,[ISOWeekNumber])

	SELECT [Date]
		  ,[DayNumber]
		  ,[Day]
		  ,[Month]
		  ,[ShortMonth]
		  ,[CalendarMonthNumber]
		  ,[CalendarMonthLabel]
		  ,[CalendarYear]
		  ,[CalendarYearLabel]
		  ,[FiscalMonthNumber]
		  ,[FiscalMonthLabel]
		  ,[FiscalYear]
		  ,[FiscalYearLabel]
		  ,[ISOWeekNumber]
	  FROM [wwilakehouse].[dbo].[Date]
end
GO

--Employee

create OR ALTER procedure [dbo].[load_dimension_Employee] as
begin
	delete from [dbo].[dimension_Employee]

	INSERT INTO [dbo].[dimension_Employee]
			   ([EmployeeKey]
			   ,[WWIEmployeeId]
			   ,[Employee]
			   ,[PreferredName]
			   ,[IsSalesPerson]
			  )
	SELECT 
		row_number() OVER(ORDER BY [WWIEmployeeId])
		,[WWIEmployeeId]
		,[Employee]
		,[PreferredName]
		,[IsSalesPerson]
	FROM [wwilakehouse].[dbo].[Employee]
END
GO
--SAles

--stockItem
create OR ALTER procedure dbo.load_dimension_stockitem AS
begin
	DELETE FROM  [dbo].[dimension_StockItem];

	INSERT INTO [dbo].[dimension_StockItem]
			   ([StockItemKey]
			   ,[WWIStockItemId]
			   ,[StockItem]
			   ,[color]
			   ,[SellingPackage]
			   ,[buyingPackage]
			   ,[brand]
			   ,[Size]
			   ,[unitPrice]
			   ,[RecommendedRetailPrice])
	SELECT 
		row_number() OVER(ORDER BY [WWIStockItemId])
		,[WWIStockItemId]
		,[StockItem]
		,[color]
		,[SellingPackage]
		,[buyingPackage]
		,[brand]
		,[Size]
		,[unitPrice]
		,[RecommendedRetailPrice]
	FROM [wwilakehouse].[dbo].[StockItem]
end
--customer
GO
create OR ALTER procedure [dbo].[load_dimension_customer] as
Begin

	delete from [dbo].[dimension_customer];

	INSERT INTO [dbo].[dimension_customer]
	([CustomerKey]
	,[WWICustomerID]
	,[Customer]
	,[BillToCustomer]
	,[Category]
	,[BuyingGroup]
	,[PrimaryContact]
	,[PostalCode])
	SELECT 
		row_number() OVER(ORDER BY [WWICustomerID])
		,[WWICustomerID]
		,[Customer]
		,[BillToCustomer]
		,[Category]
		,[BuyingGroup]
		,[PrimaryContact]
		,[PostalCode]
	FROM [wwilakehouse].[dbo].[customer]
END




create or alter procedure dbo.[load_master] as
Begin
	exec [dbo].[load_dimension_customer]
	exec [dbo].[Load_Dimension_City]
	exec [dbo].[load_dimension_date]
	exec [dbo].[load_dimension_Employee]
	exec [dbo].[load_dimension_stockitem]
end


exec dbo.[load_master]