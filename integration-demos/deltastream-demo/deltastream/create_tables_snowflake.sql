CREATE TABLE ds_account
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'account',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM account_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_accountrepayloan
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'accountrepayloan',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM accountrepayloan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_accounttransferaccount
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'accounttransferaccount',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM accounttransferaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_accountwithdrawaccount
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'accountwithdrawaccount',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM accountwithdrawaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_company
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'company',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM company_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyapplyloan
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'companyapplyloan',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM companyapplyloan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyguaranteecompany
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'companyguaranteecompany',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM companyguaranteecompany_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyinvestcompany
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'companyinvestcompany',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM companyinvestcompany_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_companyownaccount
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'companyownaccount',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM companyownaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_loan
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'loan',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM loan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_loandepositaccount
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'loandepositaccount',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM loandepositaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_medium
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'medium',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM medium_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_mediumsigninaccount
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'mediumsigninaccount',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM mediumsigninaccount_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_person
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'person',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM person_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personapplyloan
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'personapplyloan',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM personapplyloan_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personguaranteeperson
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'personguaranteeperson',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM personguaranteeperson_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personinvestcompany
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'personinvestcompany',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM personinvestcompany_stream WITH ('starting.position' = 'earliest');

CREATE TABLE ds_personownaccount
WITH
(
  'store' = '<snowflake_store_name>',
  'snowflake.db.name' = '<snowflake_db_name>',
  'snowflake.schema.name' = '<snowflake_schema_name>',
  'snowflake.table.name' = 'personownaccount',
  'snowflake.buffer.millis' = 5000
) AS
SELECT * FROM personownaccount_stream WITH ('starting.position' = 'earliest');

