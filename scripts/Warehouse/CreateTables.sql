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
    [WWICityId] int,
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
GO
DROP TABLE IF EXISTS [dbo].[fact_sale]
GO
CREATE TABLE [dbo].[fact_sale](
	[CityKey] int null,
    [EmployeeKey] int null,
    [CustomerKey] int null,
    [InvoiceDateKey] date null,
    [StockItemKey] int null,
    [Quantity] int null,
    [UnitPrice] decimal(18,4),
    [Year] int null,
    [Month] int null
) 


