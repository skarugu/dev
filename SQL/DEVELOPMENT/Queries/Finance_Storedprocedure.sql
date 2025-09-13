SELECT 
	*,
	txn.description AS txn_description
FROM account_cleaned_transactions_table AS txn
LEFT JOIN account_cleaned_department_table AS department
ON txn.department_id = department.department_id
LEFT JOIN account_cleaned_category_table AS category
ON category.category_id = txn.category_id
LEFT JOIN account_cleaned_subcategory_table AS subcategory
ON subcategory.sub_category_id = category.sub_category_id


