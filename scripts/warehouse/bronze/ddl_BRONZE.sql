USE DataWarehouse;
GO
EXEC bronze.load_bronze
GO
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '========================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '========================================';

		PRINT '----------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT '>> Inserting data into bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\rohan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds' ;
		PRINT '---------------'


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>> Inserting data into bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
	

		FROM 'C:\Users\rohan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds' ;
		PRINT '---------------'


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>> Inserting data into bronze.crm_sales_details';
		BULK INSERT  bronze.crm_sales_details
		FROM 'C:\Users\rohan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds' ;
		PRINT '---------------'

	
		PRINT '----------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> Inserting data into bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\rohan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds' ;
		PRINT '---------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '>> Inserting data into bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\rohan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds' ;
		PRINT '---------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT '>> Inserting data into bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\rohan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',' ,
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds' ;
		PRINT '---------------'

		SET @batch_end_time = GETDATE();
		PRINT '=====================';
		PRINT 'Loading Bronze layer is completed';
		PRINT ' -Total Load time is: ' + cast(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) +' seconds';
		PRINT '=====================';
		END TRY
	BEGIN CATCH
		PRINT '======================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE:' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE:' + CAST( ERROR_NUMBER() as NVARCHAR);
		PRINT 'ERROR MESSAGE:' + CAST( ERROR_STATE() as NVARCHAR);
		PRINT '======================';
	END CATCH
END