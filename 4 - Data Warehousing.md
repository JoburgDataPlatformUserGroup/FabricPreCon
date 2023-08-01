# Data Warehousing 

# Create Tables

1. Select Workspaces in the navigation menu.

2. Select the workspace created in Tutorial: Create a Microsoft Fabric data workspace, such as Data Warehouse Tutorial.

3. From the item list, select WideWorldImporters with the type of Warehouse.

    ![Screenshot of the warehouse option that appears in the item list.](/images/select-the-warehouse.png)

4. From the ribbon, select New SQL query.

    ![Screenshot of the New SQL query option where it appears on the ribbon.](/images/ribbon-new-sql-query.png)

5. In the query editor, paste the following code.

```SQL

/*
1. Drop the dimension_city table if it already exists.
2. Create the dimension_city table.
3. Drop the fact_sale table if it already exists.
4. Create the fact_sale table.
*/

--dimension_city
DROP TABLE IF EXISTS [dbo].[dimension_city];
CREATE TABLE [dbo].[dimension_city]
    (
        [CityKey] [int] NULL,
        [WWICityID] [int] NULL,
        [City] [varchar](8000) NULL,
        [StateProvince] [varchar](8000) NULL,
        [Country] [varchar](8000) NULL,
        [Continent] [varchar](8000) NULL,
        [SalesTerritory] [varchar](8000) NULL,
        [Region] [varchar](8000) NULL,
        [Subregion] [varchar](8000) NULL,
        [Location] [varchar](8000) NULL,
        [LatestRecordedPopulation] [bigint] NULL,
        [ValidFrom] [datetime2](6) NULL,
        [ValidTo] [datetime2](6) NULL,
        [LineageKey] [int] NULL
    );

--fact_sale

DROP TABLE IF EXISTS [dbo].[fact_sale];

CREATE TABLE [dbo].[fact_sale]

    (
        [SaleKey] [bigint] NULL,
        [CityKey] [int] NULL,
        [CustomerKey] [int] NULL,
        [BillToCustomerKey] [int] NULL,
        [StockItemKey] [int] NULL,
        [InvoiceDateKey] [datetime2](6) NULL,
        [DeliveryDateKey] [datetime2](6) NULL,
        [SalespersonKey] [int] NULL,
        [WWIInvoiceID] [int] NULL,
        [Description] [varchar](8000) NULL,
        [Package] [varchar](8000) NULL,
        [Quantity] [int] NULL,
        [UnitPrice] [decimal](18, 2) NULL,
        [TaxRate] [decimal](18, 3) NULL,
        [TotalExcludingTax] [decimal](29, 2) NULL,
        [TaxAmount] [decimal](38, 6) NULL,
        [Profit] [decimal](18, 2) NULL,
        [TotalIncludingTax] [decimal](38, 6) NULL,
        [TotalDryItems] [int] NULL,
        [TotalChillerItems] [int] NULL,
        [LineageKey] [int] NULL,
        [Month] [int] NULL,
        [Year] [int] NULL,
        [Quarter] [int] NULL
    );


```
6. Select Run to execute the query.
    ![Screenshot of the top corner of the query editor screen, showing where to select Run.](/images/run-to-execute.png)

7. To save this query for reference later, right-click on the query tab just above the editor and select Rename.

    ![Screenshot of the top corner of the query editor screen, showing where to right-click to select the Rename option.](/images/rename-query-option.png)

8. Type Create Tables to change the name of the query.

9. Press **Enter** on the keyboard or select anywhere outside the tab to save the change.

10. Validate the table was created successfully by selecting the refresh button on the ribbon.

    ![Screenshot of the ribbon on the Home screen, showing where to select the refresh option.](/images/home-ribbon-refresh.png)

11. In the Object explorer, verify that you can see the newly created Create Tables query, fact_sale table, and dimension_city table.

    ![Screenshot of the Explorer pane, showing where to find your tables and newly created query.](/images/object-explorer-verify.png)

# Load tables using T-SQL

1. From the ribbon, select New SQL query.

`![Screenshot of the Home screen ribbon, showing where to select New SQL query.](/images/home-ribbon-select-new.png)

2. In the query editor, paste the following code.

```SQL

--Copy data from the public Azure storage account to the dbo.dimension_city table.
COPY INTO [dbo].[dimension_city]
FROM 'https://azuresynapsestorage.blob.core.windows.net/sampledata/WideWorldImportersDW/tables/dimension_city.parquet'
WITH (FILE_TYPE = 'PARQUET');

--Copy data from the public Azure storage account to the dbo.fact_sale table.
COPY INTO [dbo].[fact_sale]
FROM 'https://azuresynapsestorage.blob.core.windows.net/sampledata/WideWorldImportersDW/tables/fact_sale.parquet'
WITH (FILE_TYPE = 'PARQUET');
```
3. Select Run to execute the query. The query takes between one and four minutes to execute.

    ![Screenshot showing where to select Run to execute your query.](/images/select-run-option.png)

4. After the query is completed, review the messages to see the rows affected which indicated the number of rows that were loaded into the dimension_city and fact_sale tables respectively.

    ![Screenshot of a list of messages, showing where to find the number of rows that were loaded into the tables.](/images/review-query-messages.png)

5. Load the data preview to validate the data loaded successfully by selecting on the fact_sale table in the Explorer.

    ![Screenshot of the Explorer, showing where to find and select the table.](/images/explorer-select-table.png)

6. Rename the query for reference later. Right-click on SQL query 1 in the Explorer and select Rename.

    ![Screenshot of the Explorer pane, showing where to right-click on the table name and select Rename.](/images/right-click-rename.png)

7. Type Load Tables to change the name of the query.

8. Press Enter on the keyboard or select anywhere outside the tab to save the change.

# Transform Data using Stored Procedures

1. From the Home tab of the ribbon, select New SQL query.

![Screenshot of the ribbon of the Home tab, showing where to select New SQL query.](/images/select-new-query.png)

2. In the query editor, paste the following code to create the stored procedure **dbo.populate_aggregate_sale_by_city**. This stored procedure will create and load the **dbo.aggregate_sale_by_date_city** table in a later step.

```SQL

--Drop the stored procedure if it already exists.
DROP PROCEDURE IF EXISTS [dbo].[populate_aggregate_sale_by_city]
GO

--Create the populate_aggregate_sale_by_city stored procedure.
CREATE PROCEDURE [dbo].[populate_aggregate_sale_by_city]
AS
BEGIN
    --If the aggregate table already exists, drop it. Then create the table.
    DROP TABLE IF EXISTS [dbo].[aggregate_sale_by_date_city];
    CREATE TABLE [dbo].[aggregate_sale_by_date_city]
        (
            [Date] [DATETIME2](6),
            [City] [VARCHAR](8000),
            [StateProvince] [VARCHAR](8000),
            [SalesTerritory] [VARCHAR](8000),
            [SumOfTotalExcludingTax] [DECIMAL](38,2),
            [SumOfTaxAmount] [DECIMAL](38,6),
            [SumOfTotalIncludingTax] [DECIMAL](38,6),
            [SumOfProfit] [DECIMAL](38,2)
        );

    --Reload the aggregated dataset to the table.
    INSERT INTO [dbo].[aggregate_sale_by_date_city]
    SELECT
        FS.[InvoiceDateKey] AS [Date], 
        DC.[City], 
        DC.[StateProvince], 
        DC.[SalesTerritory], 
        SUM(FS.[TotalExcludingTax]) AS [SumOfTotalExcludingTax], 
        SUM(FS.[TaxAmount]) AS [SumOfTaxAmount], 
        SUM(FS.[TotalIncludingTax]) AS [SumOfTotalIncludingTax], 
        SUM(FS.[Profit]) AS [SumOfProfit]
    FROM [dbo].[fact_sale] AS FS
    INNER JOIN [dbo].[dimension_city] AS DC
        ON FS.[CityKey] = DC.[CityKey]
    GROUP BY
        FS.[InvoiceDateKey],
        DC.[City], 
        DC.[StateProvince], 
        DC.[SalesTerritory]
    ORDER BY 
        FS.[InvoiceDateKey], 
        DC.[StateProvince], 
        DC.[City];
END
```

3. To save this query for reference later, right-click on the query tab just above the editor and select Rename.

    ![Screenshot of the tabs above the editor screen, showing where to right-click on the query and select Rename.](/images/query-tab-select-rename.png)

4. Type Create Aggregate Procedure to change the name of the query.

5. Press Enter on the keyboard or select anywhere outside the tab to save the change.

6. Select Run to execute the query.

7. Select the refresh button on the ribbon.

    ![Screenshot of the Home ribbon, showing where to select the Refresh button.](/images/refresh-option-ribbon.png)

8. In the Object explorer, verify that you can see the newly created stored procedure by expanding the StoredProcedures node under the dbo schema.

    ![Screenshot of the Explorer pane, showing where to expand the StoredProcedures node to find your newly created procedure.](/images/explorer-expand-node.png)

9. From the Home tab of the ribbon, select New SQL query.

10. In the query editor, paste the following code. This T-SQL executes dbo.populate_aggregate_sale_by_city to create the dbo.aggregate_sale_by_date_city table.

```SQL

--Execute the stored procedure to create the aggregate table.
EXEC [dbo].[populate_aggregate_sale_by_city];
```
11. To save this query for reference later, right-click on the query tab just above the editor and select **Rename**.

12. Type **Run Create Aggregate Procedure** to change the name of the query.

13. Press **Enter** on the keyboard or select anywhere outside the tab to save the change.

14. Select **Run** to execute the query.

15. Select the **refresh** button on the ribbon. The query takes between two and three minutes to execute.

16. In the **Object explorer**, load the data preview to validate the data loaded successfully by selecting on the aggregate_sale_by_city table in the **Explorer**.

    ![Screenshot of the Explorer pane next to a Data preview screen that lists the data loaded into the selected table.](/images/validate-loaded-data.png)

# Query Data with visual Query builder

1. From the Home tab of the ribbon, select New visual query.

    ![Screenshot of the ribbon, showing where to select New visual query.](/images/select-new-visual.png)

2. Drag the fact_sale table from the Explorer to the query design pane.

    ![Screenshot of the explorer pane next to the query design pane, showing where to drag the table.](/images/drag-drop-table.png)

3. Limit the dataset size by selecting Reduce rows > Keep top rows from the transformations ribbon.

    ![Screenshot of the Reduce rows drop-down menu, showing where to select the Keep top rows option.](/images/keep-top-rows-option.png)

4. In the Keep top rows dialog, enter 10000.

5. Select **OK**.

6. Drag the dimension_city table from the explorer to the query design pane.

7. From the transformations ribbon, select the dropdown next to Combine and select Merge queries as new.

    ![Screenshot of the transformations ribbon with the Combine drop-down menu open, showing where to select Merge queries as new.](/images/merge-queries-new.png)

8. On the Merge settings page:

    - In the Left table for merge dropdown, choose dimension_city

    - In the Right table for merge dropdown, choose fact_sale

    - Select the CityKey field in the dimension_city table by selecting on the column name in the header row to indicate the join column.

    - Select the CityKey field in the fact_sale table by selecting on the column name in the header row to indicate the join column.

    - In the Join kind diagram selection, choose Inner.

    ![Screenshot of the Merge dialog box, showing where to find table names and CityKey fields.](/images/merge-settings-details.png)

9. Select OK.

10. With the Merge step selected, select the Expand button next to fact_sale on the header of the data grid then select the columns TaxAmount, Profit, and TotalIncludingTax.

    ![Screenshot of the table with Merge selected and TaxAmount, Profit, and TotalIncludingTax selected.](/images/table-expand-selected.png)

11. Select **OK**.

12. Select **Transform > Group by** from the transformations ribbon.

    ![Screenshot of the transformations ribbon, showing where to select Group by from the Transform drop-down menu.](/images/transform-group-by.png)

13. On the **Group by** settings page:

    - Change to **Advanced**.

    - Group by (if necessary, select Add grouping to add more group by columns):

        i) Country

        ii) StateProvince

        iii) City

    - New column name (if necessary, select Add aggregation to add more aggregate columns and operations):

        - SumOfTaxAmount
            Choose Operation of Sum and Column of TaxAmount.
        - SumOfProfit
            Choose Operation of Sum and Column of Profit.
        - SumOfTotalIncludingTax
            Choose Operation of Sum and Column of TotalIncludingTax.


    ![Screenshot of the Group by settings page with the correct values entered and selected.](/images/group-by-settings.png)

14. Select **OK**.

15. Right-click on **Visual query 1** in the **Explorer** and select **Rename**.

    ![Screenshot showing where to right select on the new visual query in the Explorer pane, and where to select Rename.](/images/rename-visual-query.png)

16. Type <mark>Sales Summary</mark> to change the name of the query.

17. Press **Enter** on the keyboard or select anywhere outside the tab to save the change.

**End of Excercise 4**
