--city
CREATE OR ALTER PROCEDURE dbo.Load_dimension_City AS
Begin

    DELETE FROM [dbo].[dimension_city]

    INSERT INTO [dbo].[dimension_city]( [CityKey],[WWICityId],[City],[StateProvince],[Country] )
    SELECT row_number() OVER(ORDER BY WWICityId) [CityKey], WWICityId,City,StateProvince,Country 
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

--SAles
GO
create or alter procedure [dbo].[load_fact_sales] as
begin
    delete from dbo.fact_sale
    
    insert into dbo.fact_sale([CityKey],[EmployeeKey],[CustomerKey],[InvoiceDateKey],[StockItemKey],[Quantity],[UnitPrice],[Year],[Month])
	SELECT 
    [DC].[CityKey]
	,[DE].[EmployeeKey]
    ,DCust.CustomerKey
	,[InvoiceDate] [InvoiceDateKey]
	,DS.[StockItemKey]
	,[Quantity]
	,[UnitPrice]
	,[Year]
	,[Month]
    FROM [wwilakehouse].[dbo].[Sales] S
	LEFT JOIN [dbo].[dimension_city] DC ON DC.WWICityId = S.[WWICityID] 
	LEFT JOIN [dbo].[dimension_Employee] DE ON DE.WWIEmployeeId = S.WWIEmployeeID
	LEFT JOIN [dbo].[dimension_StockItem] DS ON DS.[WWIStockItemId] = S.WWIStockItemID
    left join [dbo].[dimension_customer] DCust ON DCust.WWICustomerID = S.WWICustomerID 

end
GO

create or alter procedure dbo.[load_master] as
Begin
	exec [dbo].[load_dimension_customer]
	exec [dbo].[Load_Dimension_City]
	exec [dbo].[load_dimension_date]
	exec [dbo].[load_dimension_Employee]
	exec [dbo].[load_dimension_stockitem]
	exec [dbo].[load_fact_sales]
end
