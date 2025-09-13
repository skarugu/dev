
CREATE PROCEDURE finance_outflow_sp()
LANGUAGE plpgsql
AS $$
BEGIN
	WITH join_tables AS (
		SELECT 
			*,
			txn.description AS txn_description
		FROM account_cleaned_transactions_table AS txn
		LEFT JOIN account_cleaned_department_table AS department
		ON txn.department_id = department.department_id
		LEFT JOIN account_cleaned_category_table AS category
		ON category.category_id = txn.category_id
		LEFT JOIN account_cleaned_subcategory_table AS subcategory
		ON subcategory.sub_category_id = txn.subcategory_id
		LEFT JOIN accounts_cleaned_location AS loct
		ON loct.location_id = txn.location_id
	),
	--To make this query more descriptive
	important_columns AS (
		SELECT 
			transaction_date,
			qty AS quantity,
			"type",
			amount AS transaction_amount,
			transaction_cost,
			amount + transaction_cost AS total_cost,
			payment_method,
			txn_description,
			"name" AS department_name,
			category_name,
			sub_category_name,
			location_name
		FROM join_tables
	)
	SELECT
		*,
		SUM(total_cost) OVER(PARTITION BY department_name) AS cost_per_department_total,
		SUM(total_cost) OVER(PARTITION BY location_name) AS cost_per_location_total,
		SUM(total_cost) OVER(PARTITION BY category_name) AS cost_per_category_total,
		SUM(total_cost) OVER(PARTITION BY sub_category_name) AS cost_per_subcategory_total
	FROM important_columns
END
$$;


		




