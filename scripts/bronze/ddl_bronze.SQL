/*
====================================================================================================================
DDL script: Create Bronze Tables
====================================================================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping existing tables if they already exist.
  Run this script to re-define the DDL structure of 'bronze' Tables
====================================================================================================================
*/

CREATE OR ALTER PROCEDURE  bronze.load_bronze AS  /* Create a procudere for frequently used queries */
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	
	BEGIN TRY /* Handle Errors */

	SET @batch_start_time=GETDATE();

		PRINT '==============================';
		PRINT 'Loading the Bronze Layer';
		PRINT '==============================';

		PRINT '------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------';


		--============== crm_cust_info
		SET @start_time=GETDATE();

		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info /* first empty table */	

		PRINT '>> Instering Table: bronze.crm_cust_info'; 
		BULK INSERT bronze.crm_cust_info  /* load data from csv */	
		FROM 'C:\Users\mitso\Documents\Udemy - SQL Course\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';
		
		--============== crm_prd_info
		SET @start_time=GETDATE();
		

		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>> Instering Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\mitso\Documents\Udemy - SQL Course\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		--============== crm_sales_details
		SET @start_time=GETDATE();
		

		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>> Instering Table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\mitso\Documents\Udemy - SQL Course\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time=GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		PRINT '------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------';
	
		--============== erp_cust_az12
		SET @start_time=GETDATE();
		
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> Instering Table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\mitso\Documents\Udemy - SQL Course\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time=GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		--============== erp_loc_101
		SET @start_time=GETDATE();
		
		PRINT '>> Truncating Table: bronze.erp_loc_101';
		TRUNCATE TABLE bronze.erp_loc_101

		PRINT '>> Instering Table: erp_loc_101';
		BULK INSERT bronze.erp_loc_101
		FROM 'C:\Users\mitso\Documents\Udemy - SQL Course\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		--============== erp_px_cat_g1v2
		SET @start_time=GETDATE();
		
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT '>> Instering Table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\mitso\Documents\Udemy - SQL Course\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time=GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		SET @batch_end_time=GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT ' - Total Load Duration: ' + CAST( DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================================';

	END TRY
	BEGIN CATCH
		PRINT '================================================'
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message ' + ERROR_MESSAGE();
		PRINT 'Error Message ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '================================================'

	END CATCH
END
