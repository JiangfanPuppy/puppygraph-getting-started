CREATE TABLE ds_account
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'account',
  'table.data.file.location' = 's3://<your_bucket_path>/account/'
) AS
SELECT * FROM account_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_accountrepayloan
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'accountrepayloan',
  'table.data.file.location' = 's3://<your_bucket_path>/accountrepayloan/'
) AS
SELECT * FROM accountrepayloan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_accounttransferaccount
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'accounttransferaccount',
  'table.data.file.location' = 's3://<your_bucket_path>/accounttransferaccount/'
) AS
SELECT * FROM accounttransferaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_accountwithdrawaccount
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'accountwithdrawaccount',
  'table.data.file.location' = 's3://<your_bucket_path>/accountwithdrawaccount/'
) AS
SELECT * FROM accountwithdrawaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_company
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'company',
  'table.data.file.location' = 's3://<your_bucket_path>/company/'
) AS
SELECT * FROM company_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyapplyloan
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'companyapplyloan',
  'table.data.file.location' = 's3://<your_bucket_path>/companyapplyloan/'
) AS
SELECT * FROM companyapplyloan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyguaranteecompany
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'companyguaranteecompany',
  'table.data.file.location' = 's3://<your_bucket_path>/companyguaranteecompany/'
) AS
SELECT * FROM companyguaranteecompany_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyinvestcompany
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'companyinvestcompany',
  'table.data.file.location' = 's3://<your_bucket_path>/companyinvestcompany/'
) AS
SELECT * FROM companyinvestcompany_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyownaccount
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'companyownaccount',
  'table.data.file.location' = 's3://<your_bucket_path>/companyownaccount/'
) AS
SELECT * FROM companyownaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_loan
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'loan',
  'table.data.file.location' = 's3://<your_bucket_path>/loan/'
) AS
SELECT * FROM loan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_loandepositaccount
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'loandepositaccount',
  'table.data.file.location' = 's3://<your_bucket_path>/loandepositaccount/'
) AS
SELECT * FROM loandepositaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_medium
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'medium',
  'table.data.file.location' = 's3://<your_bucket_path>/medium/'
) AS
SELECT * FROM medium_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_mediumsigninaccount
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'mediumsigninaccount',
  'table.data.file.location' = 's3://<your_bucket_path>/mediumsigninaccount/'
) AS
SELECT * FROM mediumsigninaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_person
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'person',
  'table.data.file.location' = 's3://<your_bucket_path>/person/'
) AS
SELECT * FROM person_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personapplyloan
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'personapplyloan',
  'table.data.file.location' = 's3://<your_bucket_path>/personapplyloan/'
) AS
SELECT * FROM personapplyloan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personguaranteeperson
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'personguaranteeperson',
  'table.data.file.location' = 's3://<your_bucket_path>/personguaranteeperson/'
) AS
SELECT * FROM personguaranteeperson_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personinvestcompany
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'personinvestcompany',
  'table.data.file.location' = 's3://<your_bucket_path>/personinvestcompany/'
) AS
SELECT * FROM personinvestcompany_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personownaccount
WITH
(
  'store' = '<databricks_store_name>',
  'databricks.catalog.name' = '<databricks_catalog_name>',
  'databricks.schema.name' = '<databricks_schema_name>',
  'databricks.table.name' = 'personownaccount',
  'table.data.file.location' = 's3://<your_bucket_path>/personownaccount/'
) AS
SELECT * FROM personownaccount_stream WITH ('starting.position' = 'earliest');

