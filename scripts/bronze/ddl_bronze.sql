/*
===================================================================================================
DDL Script: Create Bronze Table
===================================================================================================
Purpose:
	This script creates tables in the 'bronze' schema, dropping existing tables if it already exits.
	Run this script to re-define the DDL structre of 'bronze' Tables
===================================================================================================
*/

--For MySQL we need T-SQL logic to make updates to the table or check if table already exists
if object_id ('bronze.crm_cust_info', 'U') is not null
	drop table bronze.crm_cust_info;
create table bronze.crm_cust_info( 
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_martial_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_data DATE
);


GO

if object_id ('bronze.crm_prd_info', 'U') is not null
	drop table bronze.crm_prd_info;
create table bronze.crm_prd_info (
prd_id int,
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt datetime,
prd_end_date datetime
);


GO

if object_id ('bronze.crm_sales_details', 'U') is not null
	drop table bronze.crm_sales_details;
create table bronze.crm_sales_details (
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_date int,
sls_sales int,
sls_quantity int,
sls_price int
);

GO

if object_id ('bronze.erp_cust_az12', 'U') is not null
	drop table bronze.erp_cust_az12;
create table bronze.erp_cust_az12 (
cid nvarchar(50),
bdate date,
gen nvarchar(50)
);

GO

if object_id ('bronze.erp_loc_a101', 'U') is not null
	drop table bronze.erp_loc_a101;
create table bronze.erp_loc_a101 (
cid nvarchar(50),
cntry nvarchar(50)
);

GO

if object_id ('bronze.erp_px_cat_g1v2', 'U') is not null
	drop table bronze.erp_px_cat_g1V2;
create table bronze.erp_px_cat_g1V2 (
id nvarchar(50),
cat nvarchar(50),
subcat nvarchar(50),
maintenance nvarchar(50)
);
