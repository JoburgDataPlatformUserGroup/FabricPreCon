# Create reports

1. Select the Model view from the options in the bottom left corner, just outside the canvas.

![Screenshot of the bottom left corner of the screen, showing where to select the Model view option.](/images/select-model-view.png)

2. From the fact_sale table, drag the CityKey field and drop it onto the CityKey field in the dimension_city table to create a relationship.

![Screenshot of two table field lists, showing where to drag a field from one table to another.](/images/drag-field-drop-table.png)

3. On the Create Relationship settings:

    a) Table 1 is populated with fact_sale and the column of CityKey.
    b) Table 2 is populated with dimension_city and the column of CityKey.
    c) Cardinality: select Many to one (*:1).
    d) Cross filter direction: select Single.
    e) Leave the box next to Make this relationship active checked.
    f) Check the box next to Assume referential integrity.

![Screenshot of the Create Relationship screen, showing the specified values and where to select Assume referential integrity.](/images/create-relationship-dialog.png)

4. Select Confirm.

5. From the Home tab of the ribbon, select New report.

6. Build a Column chart visual:

    - On the Data pane, expand fact_sales and check the box next to Profit. This creates a column chart and adds the field to the Y-axis.

    - On the Data pane, expand dimension_city and check the box next to SalesTerritory. This adds the field to the X-axis.

    - Reposition and resize the column chart to take up the top left quarter of the canvas by dragging the anchor points on the corners of the visual.

    ![Screenshot showing where to find the anchor point at the corner of a new visual report in the canvas screen.](/images/new-visual-canvas-anchor.png)

7. Select anywhere on the blank canvas (or press the Esc key) so the column chart visual is no longer selected.

8. Build a Maps visual:

    1. On the Visualizations pane, select the ArcGIS Maps for Power BI visual.

    ![Screenshot of the Visualizations pane showing where to select the ArcGIS Maps for Power BI option.](/images/visualizations-pane-arcgis-maps.png)

    2. From the Data pane, drag StateProvince from the dimension_city table to the Location bucket on the Visualizations pane.

    3. From the Data pane, drag Profit from the fact_sale table to the Size bucket on the Visualizations pane.

    ![Screenshot of the Data pane next to the Visualization pane, showing where to drag the relevant data.](/images/drag-data-to-visualization.png)

    4. If necessary, reposition and resize the map to take up the bottom left quarter of the canvas by dragging the anchor points on the corners of the visual.

    ![Screenshot of the canvas next to the Visualization and Data panes, showing a bar chart and a map plot on the canvas.](/images/canvas-two-visual-reports.png)

9. Select anywhere on the blank canvas (or press the Esc key) so the map visual is no longer selected.

10. Build a Table visual:

    a) On the Visualizations pane, select the Table visual.

    ![Screenshot of the Visualizations pane showing where to select the Table option.](/images/select-table-visualization.png)

    b) From the Data pane, check the box next to SalesTerritory on the dimension_city table.

    c) From the Data pane, check the box next to StateProvince on the dimension_city table.

    d) From the Data pane, check the box next to Profit on the fact_sale table.

    e) From the Data pane, check the box next to TotalExcludingTax on the fact_sale table.

    f) Reposition and resize the column chart to take up the right half of the canvas by dragging the anchor points on the corners of the visual.

    ![Screenshot of the canvas next to the Visualization and Data panes, which show where to select the specified details. The canvas contains a bar chart, a map plot, and a table.](/images/canvas-three-reports.png)

11. From the ribbon, select File > Save.

12. Enter Sales Analysis as the name of your report.

13. Select Save.

    ![Screenshot of the Save your report dialog box with Sales Analysis entered as the report name.](/images/save-sales-analysis-report.png)