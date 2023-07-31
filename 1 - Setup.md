# Setup

# Create a workspace (Excercise)
The workspace contains all the items needed for data warehousing, including: Data Factory pipelines, the data warehouse, Power BI datasets, and reports.

1. Open the following [Link](https://app.powerbi.com).
2. Select Workspaces > New workspace.

![Screenshot of workspaces pane showing where to select New workspace.](/images/create-new-workspace.png)

3. Fill out the Create a workspace form as follows:

 - **Name**: FabricWorkshop_{*Enter your name here*}.
 - **Description**: Optionally, enter a description for the workspace.
Screenshot of the Create a workspace dialog box, showing where to enter the new workspace name.

4. Expand the **Advanced** section.

5. Choose Fabric capacity or Trial in the License mode section. 

        *We will use the Trial Capacity for this workshop*

6. Select **Apply**. The workspace is created and opened.

    ![The create workspace repo](/images/CreateWorkspace.png)

### Open an existing workspace

7. In the Power BI service, select Workspaces from the left-hand menu.

8. To open your workspace, enter its name in the search textbox located at the top and select it from the search results.

# Create a lakehouse


1. From the experience switcher located at the bottom left, select Data Engineering.
    ![Screenshot showing where to select the experience switcher and Data Engineering.](/images/workload-switch-data-engineering.png)


2. In the Data Engineering tab, select Lakehouse to create a lakehouse.
    ![Create Lakehouse](/images/Create-lakehouse.png)

3. In the New lakehouse dialog box, enter wwilakehouse in the Name field.

    ![Screenshot of the New lakehouse dialog box.](/images/new-lakehouse-name.png)

4. Select Create to create and open the new lakehouse.

# Create a warehouse

1. From the experience switcher located at the bottom left, select Data Engineering.
    ![](/images/change-to-datawarehouse.png)

2. Select the **+ New** button to display a full list of available items. From the list of objects to create, choose **Warehouse (Preview)** to create a new Warehouse in Microsoft Fabric
    ![Screenshot of the workspace screen, showing where to select Warehouse (Preview) in the New drop-down menu.](/images/create-warehouse.png)

3. On the New warehouse dialog, enter WideWorldImporters as the name.

4. Select **Create**.

    ![Screenshot of the New warehouse dialog box, showing where to enter a warehouse name, set the Sensitivity, and select Create.](/images/Save-warehouse.png)

5. When provisioning is complete, the Build a warehouse landing page appears.

    ![Screenshot of the Build a warehouse landing page.](/images/New-warehouse.png)

    ***End of Excercise 1***