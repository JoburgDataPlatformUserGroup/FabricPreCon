# Data Warehousing 

# Create Tables

1. Select Workspaces in the navigation menu.

2. Select the workspace created in Excercise 1, such as Data Warehouse Tutorial.

3. From the item list, select **wwiwarehouse** with the type of Warehouse.

    ![Screenshot of the warehouse option that appears in the item list.](/images/select-the-warehouse.png)

4. From the ribbon, select New SQL query.

    ![Screenshot of the New SQL query option where it appears on the ribbon.](/images/ribbon-new-sql-query.png)

5. In the query editor, paste the following code.

```SQL

DROP TABLE IF EXISTS [dbo].[dimension_date];
CREATE TABLE [dbo].[dimension_date](
	[Date] [datetime2](6) NULL,
	[DayNumber] [int] NULL,
	[Day] [varchar](8000) NULL,
	[Month] [varchar](8000) NULL,
	[ShortMonth] [varchar](8000) NULL,
	[CalendarMonthNumber] [int] NULL,
	[CalendarMonthLabel] [varchar](8000) NULL,
	[CalendarYear] [int] NULL,
	[CalendarYearLabel] [varchar](8000) NULL,
	[FiscalMonthNumber] [int] NULL,
	[FiscalMonthLabel] [varchar](8000) NULL,
	[FiscalYear] [int] NULL,
	[FiscalYearLabel] [varchar](8000) NULL,
	[ISOWeekNumber] [int] NULL
);
GO
DROP TABLE IF EXISTS [dbo].[dimension_city]
GO
CREATE TABLE [dbo].[dimension_city]
(
    [CityKey] INT NOT NULL,
    [CityId] int,
    [City] varchar(255),
    [StateProvince] varchar(255),
    [Country] varchar(255)
)
GO
DROP TABLE IF EXISTS [dbo].[dimension_Employee]
GO
CREATE TABLE [dbo].[dimension_Employee](
	[EmployeeKey] INT NOT NULL,
	[WWIEmployeeId] [int] NULL,
	[Employee] [varchar](8000) NULL,
	[PreferredName] [varchar](8000) NULL,
	[IsSalesPerson] [bit] NULL
) 
GO
DROP TABLE IF EXISTS [dbo].[dimension_StockItem]
GO
CREATE TABLE [dbo].[dimension_StockItem](
	[StockItemKey] [int] NOT NULL,
	[WWIStockItemId] [int] NULL,
	[StockItem] [varchar](8000) NULL,
	[color] [varchar](8000) NULL,
	[SellingPackage] [varchar](8000) NULL,
	[buyingPackage] [varchar](8000) NULL,
	[brand] [varchar](8000) NULL,
	[Size] [varchar](8000) NULL,
	[unitPrice] [decimal](18, 2) NULL,
	[RecommendedRetailPrice] [decimal](18, 2) NULL
) 
GO
DROP TABLE IF EXISTS [dbo].[dimension_customer]
GO
CREATE TABLE [dbo].[dimension_customer](
	[CustomerKey] [bigint] NULL,
	[WWICustomerID] [bigint] NULL,
	[Customer] [varchar](8000) NULL,
	[BillToCustomer] [varchar](8000) NULL,
	[Category] [varchar](8000) NULL,
	[BuyingGroup] [varchar](8000) NULL,
	[PrimaryContact] [varchar](8000) NULL,
	[PostalCode] [varchar](8000) NULL,
) 


```
6. Select Run to execute the query.

    ![Screenshot of the top corner of the query editor screen, showing where to select Run.](/images/run-to-execute.png)

7. To save this query for reference later, right-click on the query tab just above the editor and select Rename.

    ![Screenshot of the top corner of the query editor screen, showing where to right-click to select the Rename option.](/images/rename-query-option.png)

8. Type **Create Tables** to change the name of the query.

9. Press **Enter** on the keyboard or select anywhere outside the tab to save the change.

10. Validate the tables were created successfully by selecting the refresh button on the ribbon.

    ![Screenshot of the ribbon on the Home screen, showing where to select the refresh option.](/images/home-ribbon-refresh.png)

11. In the Object explorer, verify that you can see the newly created Create Tables.

    ![Screenshot of the Explorer pane, showing where to find your tables and newly created query.](/images/object-explorer-verify.png)

# Load tables using T-SQL

1. From the ribbon, select New SQL query.

`![Screenshot of the Home screen ribbon, showing where to select New SQL query.](/images/home-ribbon-select-new.png)

2. In the query editor, paste the following code.

```SQL

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


```
3. Select **Run** to execute the query. 

    ![Screenshot showing where to select Run to execute your query.](/images/select-run-option.png)

4. This script has created 7 Stored procedures, one that loads each of the 5 dimension tables, 1 that Loads the Fact table, and a controler Stored Procedure that clles the procedures in the correct order.

5. To Execte the **load_master** procedure, open a new query window and enter the following code 

```sql
exec dbo.[load_master]
```

6. Select run **Run** to execute all the procedures, this command may take several minutes. 


5. After the query is completed, review the messages to see the rows affected which indicated the number of rows that were loaded into the dimension and fact tables respectively.

    ![Screenshot of a list of messages, showing where to find the number of rows that were loaded into the tables.](/images/review-query-messages.png)

6. Load the data preview to validate the data loaded successfully by selecting on the fact_sale table in the Explorer.

    ![Screenshot of the Explorer, showing where to find and select the table.](/images/explorer-select-table.png)

6. Rename the query for reference later. Right-click on **SQL query 1** in the Explorer and select Rename.

    ![Screenshot of the Explorer pane, showing where to right-click on the table name and select Rename.](/images/right-click-rename.png)

7. Type **Load Tables** to change the name of the query.

8. Press Enter on the keyboard or select anywhere outside the tab to save the change.


**End of Excercise 4**
