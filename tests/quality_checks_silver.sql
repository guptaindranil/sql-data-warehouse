-- check unwanted spaces in string
-- expectation: No result
select maintenance
from bronze.erp_px_cat_g1v2
where maintenance != trim(maintenance);

select cst_lastname
from silver.crm_cust_info
where cst_lastname != trim(cst_lastname);

-- Checnk for nulls or duplicates in PK
-- Expectation: No Results
select cst_id, count(*)
from silver.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null;

select prd_id, count(*)
from silver.crm_prd_info
group by prd_id
having count(*)>1 or prd_id is null;

--Check for NULL of negativve nubers
--Expectation- No Results
select prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null

--Data standardization and consistency
select distinct maintenance
from bronze.erp_px_cat_g1v2;

--Check for Invalid Date Orders
 select *
 from silver.crm_prd_info
 where prd_end_dt < prd_start_dt;

select *
from silver.crm_prd_info
where prd_cost = 0;

--Check Invalid  Dates
--Expectation-  No result
select
nullif(sls_due_date,0) as sls_due_dt
from bronze.crm_sales_details
where sls_due_dt <= 0 
or len(sls_due_dt) != 8
or sls_due_dt > 20500101
or sls_due_dt < 19000101;

--Invalid Date order
--Expectation: No result 
select *
from silver.crm_sales_details
where sls_ship_dt > sls_due_dt or sls_order_dt > sls_due_dt;

--Check data consistency: Between Sales, Quantity and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or negative

select distinct
sls_sales as old_sls_sales,
sls_quantity,
sls_price as old_sls_proce,
case when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity * abs(sls_price)
	 then sls_quantity * abs(sls_price)
	 else sls_sales
end as sls_sales,
case when sls_price is null or sls_price<=0 
	 then sls_sales / nullif(sls_quantity,0)
	 else sls_price
end as sls_price
from bronze.crm_sales_details
where sls_sales != sls_quantity * sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity <=0 or sls_price <=0
order by sls_sales, sls_quantity, sls_price

--Check out of range dates
select bdate
from bronze.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate();
