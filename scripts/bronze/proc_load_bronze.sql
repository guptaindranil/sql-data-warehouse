/*
==========================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==========================================================================================================
Script Prupose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
		- truncates the bronze tables before loading data.
		- Uses the 'BULK INSERT' command to load data from csv files to bronze tables

Parameters-
	None
	The stored procedure does not accept any parameters or return any values.

Usage Example-
	EXEC bronze.load_bronze;
==========================================================================================================
*/
create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = getdate();
		print '==================================================================';
		print 'Loading Bronze Layer';
		print '==================================================================';

		print '------------------------------------------------------------------';
		print 'Loading CRM Tables';
		print '------------------------------------------------------------------';

		--Truncate means clearing the table, otherwise running insert multiple times will keep appending the data
		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info
		print '>> Inserting data into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'D:\Projects\sql_warehouse_project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print concat('>> Load Duration: ', datediff(second, @start_time, @end_time), ' seconds');
		print '-----------------------';

		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info
		print '>> Inserting data into: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'D:\Projects\sql_warehouse_project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print concat('>> Load Duration: ', datediff(second, @start_time, @end_time), ' seconds');
		print '-----------------------';

		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details
		print '>> Inserting data into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'D:\Projects\sql_warehouse_project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print concat('>> Load Duration: ', datediff(second, @start_time, @end_time), ' seconds');
		print '-----------------------';

		print '------------------------------------------------------------------';
		print 'Loading ERP Tables';
		print '------------------------------------------------------------------';

		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12
		print '>> Inserting data into: bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'D:\Projects\sql_warehouse_project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print concat('>> Load Duration: ', datediff(second, @start_time, @end_time), ' seconds');
		print '-----------------------';

		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101
		print '>> Inserting data into: bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'D:\Projects\sql_warehouse_project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print concat('>> Load Duration: ', datediff(second, @start_time, @end_time), ' seconds');
		print '-----------------------';

		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2
		print '>> Inserting data into: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'D:\Projects\sql_warehouse_project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print concat('>> Load Duration: ', datediff(second, @start_time, @end_time), ' seconds');
		print '-----------------------';
		print 'Bronze Layer Loading Complete'
		set @batch_end_time = getdate();
		print concat('>> Batch Load Duration: ', datediff(second, @start_time, @end_time), ' seconds');
	end try
	begin catch
		print '===================================================================';
		print 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		print ' Error Message' + error_message();
		print ' Error Number' + cast(error_number() as nvarchar);
		print ' Error State' + cast(error_state() as nvarchar);
		print '===================================================================';
	end catch
end

