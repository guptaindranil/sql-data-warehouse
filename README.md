# ETL PIPELINE DEVELOPMENT & DATA WAREHOUSE DESIGN FOR CRM AND ERP SYSTEMS

This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics. A raw data source of Customer Relationship Management (CRM) and Enterprise Resource Planning (ERP) is used, and a Medallion architecture is used to load the data into the warehouse.

## Data Flow
The CRM source contributes the following data-
- Customer Info
- Product Info
- Sales details

The ERP source contributes the following data-
- Customer Info
- Location Info
- Product category Info

A star schema model is used to create actionable views. The following views are created-
- Customers (Dimension)
- Products (Dimensions)
- Sales (Fact)
  
![data_flow](https://github.com/user-attachments/assets/598b416c-ff9c-45b4-af61-9abe6c38b0eb)

## Data Architecture
The ETL pipeline uses a medallion architecture. Raw data is loaded into the bronze layer, transformed in the Silver layer, and business logic is applied in the Gold layer.

### Transformations Applied
- Data consistency- Remove unwanted spaces using TRIM
- Data Standardization- Map coded values (F,M) to  meaning values (Female, Male)
- Handling NULL values by replacing with default values 'n/a'
- Removing Duplicate values- Ensure unique entry for each PK by selecting the latest entry
- Derived Columns- prd_key has prd_cat as a substring, so defined a new column and extracted prd_cat 
- Data enrichment- Modified end date to match with next entry start date so that there is no overlapping period

![data_architecture](https://github.com/user-attachments/assets/1c2e2daa-5118-4330-9212-f7d45f218431)

## Data Integration 
The relationship between the model is mapped using unique cst_id, cst_key and prd_key. The tables are labelled according to the information they provide ,which ends up as the views in the gold layer

![data_integration](https://github.com/user-attachments/assets/5301f44b-c941-48cd-b3c6-8f4eb8b6d587)

## Data Model
The final data model is based on the Star Schema architecture and outlines the realationship between the views which can be used by the end consumer

![data_model](https://github.com/user-attachments/assets/81efc7af-40b0-455e-a784-2047a8b5f348)
