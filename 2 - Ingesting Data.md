# Ingest data

Data ingestion is the process moving data into the data repository so that it can be worked on. While Shortcuts make it possible to connect to data that already exists elsewhere it is often a requirement that we first create a local copy of the data. In this module we look at how to create such ingestion processes using eiter data pipelines or dataflows gen 2 

## Dataflow Gen2

1. In the Lakehouse explorer, you see options to load data into lakehouse. Select **New Dataflow Gen2**.

    ![Create gen 2 dataflow](/images/create-dataflow-gen2.png)

2. On the new dataflow pane, select **Import from a Text/CSV file**.


3. On the Connect to data source pane, 
    -   select the **link to file** radio button. paste the url below into **File path or URL**, select Next.

        Use the following URL
        https://raw.githubusercontent.com/JoburgDataPlatformUserGroup/FabricPreCon/main/source/customer.csv
    - Select **Create new connection** if not already selected
    - leave **Data Gateway** as **(none)**
    - Set **Authentication kind** to **Anonymous**

    ![Screenshot showing where to select Upload file and where to drag the previously downloaded file.](/images/dataflow-source.png)

4. Select **Next**.

5. When the **preview file data** pane appears validate the data 

    ![Review data source options for dataflow](/images/dataflow-reviewdata.png)

6. Select **Create**.

    ![create dataflow when happy with transformations](/images/dataflow-publish.png)



7. You can then validate that the table has been successuflly added by opening up the tables section of the 
    ![Confirm dataflow created table ](/images/dataflow-confirm-new-table.png)


# Data Pipeline

In this section, you use the Copy data activity of the Data Factory pipeline to ingest sample data from an Azure storage account to the Files section of the lakehouse you created earlier.

1. Select Workspaces in the left navigation pane, and then select your new workspace from the Workspaces menu. The items view of your workspace appears.

![Screenshot showing how to create a new data pipeline.](/images/create-data-pipeline.png)

2. From the **+New** button in the workspace page, select **Data pipeline**.

3. In the New pipeline dialog box, specify the name as **IngestDataFromSourceToLakehouse** and select **Create**. A new data factory pipeline is created and opened.

4. On your newly created data factory pipeline, select Add pipeline activity to add an activity to the pipeline and select Copy data. This action adds copy data activity to the pipeline canvas.

    ![Screenshot showing where to select Add pipeline activity and Copy data.](/images/pipeline-copy-data.png)

5. Select the newly added copy data activity from the canvas. Activity properties appear in a pane below the canvas (you may need to expand the pane upwards by dragging the top edge). Under the General tab in the properties pane, specify the name for the copy data activity Data Copy to Lakehouse.

    ![Screenshot showing where to add the copy activity name on the General tab.](/images/data-copy-to-lakehouse.png)

6. Under **Source** tab of the selected copy data activity, select **External** as **Data store type** and then select **+ New** to create a new connection to data source.

    ![screenshot showing where to select External and + New on the Source tab.](/images/data-store-source-external.png)

7. For this tutorial, all the sample data is available in a public container of Azure blob storage. You connect to this container to copy data from it. On the New connection wizard, select Azure Blob Storage and then select Continue.

    ![Screenshot of the New connection wizard, showing where to select Azure Blob Storage.](/images/new-connection-azure-blob-storage.png)

8. On the next screen of the New connection wizard, enter the following details and select Create to create the connection to the data source.

Property|	Value
---|---
Account name or URI	|https://azuresynapsestorage.blob.core.windows.net/sampledata
Connection	|Create new connection
Connection name	|wwisampledata
Authentication kind	|Anonymous

![Screenshot of the Connection settings screen, showing where to enter the details and select Create.](/images/connection-settings-details.png)

9. Once the new connection is created, return to the Source tab of the copy data activity, and the newly created connection is selected by default. Specify the following properties before moving to the destination settings.

Property	|Value
---|---
Data store type	|External
Connection	|wwisampledata
File path type	|File path
File path	Container name (first text box): |sampledata
Directory name (second text box): |WideWorldImportersDW/parquet
Recursively	|Checked
File Format	|Binary

    ![Screenshot of the source tab showing where to enter the specific details.](/images/source-tab-details.png)



10. Under the Destination tab of the selected copy data activity, specify the following properties:

Property |	Value
---|---
Data store type|	Workspace
Workspace data store type	|Lakehouse
Lakehouse	|wwilakehouse
Root Folder	|Files
File path	Directory name (first text box): |wwi-raw-data
File Format	|Binary

    ![Screenshot of the Destination tab, showing where to enter specific details.](/images/destination-tab-details.png)

11. You have finished configuring the copy data activity. Select the **Save** button on the top ribbon (under **Home**) to save your changes, and select Run to execute your pipeline and its activity. You can also schedule pipelines to refresh data at defined intervals to meet your business requirements. For this tutorial, we run the pipeline only once by clicking on **Run** button.

    This action triggers data copy from the underlying data source to the specified lakehouse and might take up to a minute to complete. You can monitor the execution of the pipeline and its activity under the Output tab, which appears when you click anywhere on the canvas. Optionally, you can select the glasses icon, which appears when you hover over the name, to look at the details of the data transfer.

![Screenshot showing where to select Save and Run, and where to find the run details and glasses icon on the Output tab.](/images/save-run-output-tab.png)

12. Once the data is copied, go to the items view of the workspace and select your new lakehouse (wwilakehouse) to launch the **Lakehouse explorer**.

![Screenshot showing where to select the lakehouse to launch the Lakehouse explorer.](/images/item-view-select-lakehouse.png)

13. Validate that in the Lakehouse explorer view, a new folder wwi-raw-data has been created and data for all the tables have been copied there.

![Screenshot showing the source data is copied into the Lakehouse explorer.](/images/validate-destination-table.png)

**End of Excercise 2**