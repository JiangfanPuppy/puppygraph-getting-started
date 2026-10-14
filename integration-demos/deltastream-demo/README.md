# Streaming Kafka Data into a Lakehouse with DeltaStream and Querying It as a Graph with PuppyGraph

## Summary

This demo streams a financial dataset through three managed services and ends with graph queries over it, without copying the data into a graph database:

1. **Confluent Cloud** hosts 18 Kafka topics, one per node or relationship type in the dataset. A small script in this folder creates the topics and produces the JSON records into them.
2. **DeltaStream** reads each topic as a *stream* and runs one continuous query per stream that writes the records into your lakehouse: Delta tables in **Databricks** (Unity Catalog on S3), or tables in **Snowflake**. DeltaStream manages the connection to both sides.
3. **PuppyGraph** connects to Databricks or Snowflake, maps the landed tables to graph nodes and edges with a schema file, and answers Gremlin and openCypher queries directly against those tables.

DeltaStream runs its queries in its own cloud, so the Kafka cluster it reads from has to be reachable from the internet. A Confluent Cloud cluster gives you that with API-key authentication and nothing to host yourself, which is why this demo uses it rather than a local broker.

## The dataset

`json_data/` holds a synthetic financial-activity graph in the shape of the [LDBC FinBench](https://ldbcouncil.org/benchmarks/finbench/) benchmark: one file per topic, one JSON object per line, 36,881 records in total.

| Node type | Records | What it is |
|-----------|--------:|------------|
| Person    |     785 | A customer: name, gender, birthday, country, city |
| Company   |     386 | A business: name, country, city, business type |
| Account   |   2,055 | A bank or brokerage account with its type, level and login history |
| Loan      |   1,376 | A loan with its amount, balance and usage |
| Medium    |     978 | A device or channel used to sign in to an account |

The other 13 files are relationships, each with a timestamp and sometimes an amount: `PersonOwnAccount`, `CompanyOwnAccount`, `PersonApplyLoan`, `CompanyApplyLoan`, `PersonGuaranteePerson`, `CompanyGuaranteeCompany`, `PersonInvestCompany`, `CompanyInvestCompany`, `AccountTransferAccount`, `AccountWithdrawAccount`, `AccountRepayLoan`, `LoanDepositAccount` and `MediumSignInAccount`. The questions at the end of the demo follow money between accounts and from people to the loans their accounts repay.

## Prerequisites

- A [Confluent Cloud](https://confluent.cloud/signup) account. The [free trial](https://docs.confluent.io/cloud/current/get-started/free-trial.html) includes $400 of credit, far more than this demo uses.
- A [DeltaStream](https://app.deltastream.io/) account. The [free trial](https://docs.deltastream.io/getting-started/trial-quick-start) limits you to 3 running queries at a time; step 4 explains how to work within that.
- One lakehouse to land the data in:
  - **Databricks**: a workspace with Unity Catalog, an S3 bucket registered as an [external location](https://docs.databricks.com/aws/en/connect/unity-catalog/cloud-storage#external-locations) in that workspace, a SQL warehouse, a personal access token, and an AWS access key with read and write access to the bucket; or
  - **Snowflake**: an account, a warehouse, and a user DeltaStream can log in as.
- Docker, to run PuppyGraph.
- Python 3.8 or later, to produce the data.

## Step 1: Create a Confluent Cloud cluster and an API key

1. Sign in to Confluent Cloud and create an environment and a **Basic** cluster in any region.
2. Open the cluster, go to **Cluster settings** and copy the **Bootstrap server**, which looks like `pkc-xxxxx.us-east-1.aws.confluent.cloud:9092`.
3. Go to **API keys**, click **Add key**, create a key for your account with global access, and save the key and secret. They are shown only once.
4. In this folder, copy the example environment file and fill in the three `CONFLUENT_*` values:

```bash
cp .env.example .env
```

Everything else in `.env` is used by PuppyGraph in step 5 and can wait.

## Step 2: Create the topics and produce the data

Create a virtual environment with the Kafka client, then create the 18 `kafka-*` topics and produce the records into them. The script reads the connection settings from `.env`.

```bash
python3 -m venv venv
source venv/bin/activate
pip install confluent-kafka

env $(cat .env | xargs) python produce_data.py -c   # create the topics
env $(cat .env | xargs) python produce_data.py -s   # produce json_data/ into them
```

The second command prints a record count per topic; `kafka-Account` should report 2,055. In the Confluent Cloud console the topics now appear under **Topics**, and opening one shows the JSON messages.

## Step 3: Connect DeltaStream to Confluent Cloud and define the streams

1. In the DeltaStream console, open **Resources**, click **+ Add Data Store** and choose **ConfluentKafka**. Give the store a name such as `confluent_demo`, paste the bootstrap server as the URI and the API key and secret, then click **Add**. Clicking the store afterwards lists the 18 topics; printing `kafka-Account` shows live records and confirms the connection. DeltaStream's [Confluent Cloud page](https://docs.deltastream.io/integrations/setting-up-data-store-integrations/confluent-cloud) covers the same dialog.
2. Open **Databases**, click **+ Add Database** and name it `kafka_db`. A namespace called `public` is created with it.
3. Open the **Workspace**, select `kafka_db` and `public` as the current database and namespace and `confluent_demo` as the current store, and run the statements in [`deltastream/create_streams.sql`](deltastream/create_streams.sql).

Each `CREATE STREAM` declares the JSON fields of one topic as typed columns and names the topic it reads from; the store is the one selected in the workspace. Streams are only definitions, so this step starts no queries.

## Step 4: Land the streams in your lakehouse

Each statement in the table scripts has the form

```sql
CREATE TABLE ds_account WITH (...) AS
SELECT * FROM account_stream WITH ('starting.position' = 'earliest');
```

It creates the target table if it does not exist and starts a continuous query that reads the stream from the beginning of its topic and writes every record into that table. These queries never finish on their own, because a stream has no end, and every running query counts against your organization's limit: 3 on the free trial. So work in batches: run as many `CREATE TABLE` statements as you have free query slots, wait until the row count in Databricks or Snowflake matches the record count the producer printed, then terminate those queries and run the next batch. Terminating a query keeps the table and its rows.

```sql
LIST QUERIES;
TERMINATE QUERY <query id>;
```

### Option A: Databricks

1. In Unity Catalog, create the catalog `pg_databricks` and inside it the schema `delta_stream_demo`. These are the names `schema_databricks.json` expects; if you use different ones, change them there too.
2. Create a prefix per table in the S3 bucket that is registered as an external location, with the bucket name and a path of your choice:

   ```bash
   for t in account accountrepayloan accounttransferaccount accountwithdrawaccount company companyapplyloan companyguaranteecompany companyinvestcompany companyownaccount loan loandepositaccount medium mediumsigninaccount person personapplyloan personguaranteeperson personinvestcompany personownaccount; do
     aws s3api put-object --bucket <your-bucket> --key delta_stream_demo/$t/
   done
   ```

3. In DeltaStream, add a **Databricks** store. The [Databricks integration page](https://docs.deltastream.io/integrations/setting-up-data-store-integrations/setting-up-and-integrating-databricks-with-your-organization) walks through it; the fields are:

   | Field | Value |
   |-------|-------|
   | Name | A store name, for example `databricks_demo` |
   | URIs | Your workspace URL, `https://dbc-xxxxxxxx-xxxx.cloud.databricks.com` |
   | Warehouse ID | The ID of a SQL warehouse in the workspace |
   | Databricks Cloud Region | The AWS region of the bucket |
   | Cloud S3 Bucket | The bucket registered as an external location |
   | App Token | A Databricks personal access token |
   | Access Key ID / Secret Access Key | An AWS key with read and write access to the bucket |

4. In [`deltastream/create_tables_databricks.sql`](deltastream/create_tables_databricks.sql), replace `<databricks_store_name>` with the store name, `<databricks_catalog_name>` with `pg_databricks`, `<databricks_schema_name>` with `delta_stream_demo` and `<your_bucket_path>` with `<your-bucket>/delta_stream_demo`, then run the statements in batches as described above. The tables appear in the Databricks catalog explorer as they are created.

### Option B: Snowflake

1. In Snowflake, create the database `DELTA_STREAM_DB`. Its `PUBLIC` schema is where the tables land and where `schema_snowflake.json` looks for them. You also need a warehouse and a user with a role that can create tables there; DeltaStream authenticates with the user's RSA key pair, which the [Snowflake integration page](https://docs.deltastream.io/integrations/setting-up-data-store-integrations/setting-up-and-integrating-snowflake-with-your-organization) shows how to set up.
2. In DeltaStream, add a **Snowflake** store:

   | Field | Value |
   |-------|-------|
   | Name | A store name, for example `snowflake_demo` |
   | URIs | `https://<account_id>.snowflakecomputing.com` |
   | Snowflake Cloud Region | The region of your Snowflake account, for example `AWS us-east-1` |
   | Account Id | The account identifier in the form `<orgname>-<account_name>` |
   | Role Name | The role to use, for example `ACCOUNTADMIN` |
   | Warehouse Name | The warehouse that runs the writes |
   | Username | The Snowflake user |
   | Client Key File / Key Passphrase | The user's private key in PEM format and its passphrase, if any |

3. In [`deltastream/create_tables_snowflake.sql`](deltastream/create_tables_snowflake.sql), replace `<snowflake_store_name>` with the store name, `<snowflake_db_name>` with `DELTA_STREAM_DB` and `<snowflake_schema_name>` with `PUBLIC`, then run the statements in batches as described above.

## Step 5: Query the tables as a graph with PuppyGraph

1. Fill in the `DATABRICKS_*` or the `SNOW_*` values in `.env`. `DATABRICKS_HOST` is the workspace host without `https://`; the AWS key is the one that can read the bucket. `SNOW_ACCOUNT_ID` is the `<orgname>-<account_name>` identifier.
2. Start PuppyGraph with that file. The schema files reference these variables as `${ENV:...}`, so the credentials never go into the schema itself.

   ```bash
   docker run -p 8081:8081 -p 8182:8182 -p 7687:7687 \
     -e DATAACCESS_DATA_CACHE_STRATEGY=adaptive \
     --env-file .env \
     -d --name puppy --rm --pull=always puppygraph/puppygraph:latest
   ```

3. Log into the Web UI at http://localhost:8081 with username `puppygraph` and password `puppygraph123`.
4. Click **Upload Schema** and upload `schema_databricks.json` or `schema_snowflake.json`. The schema maps each of the 18 tables to a node or edge label and names the columns that hold the endpoint IDs, which is all PuppyGraph needs to walk the tables as a graph.

Open the **Query** panel. The **Graph Query** tab accepts Gremlin and openCypher; the queries below are given in both.

Count the nodes:

```gremlin
g.V().count()
```

```cypher
MATCH (n) RETURN count(n)
```

Count the edges:

```gremlin
g.E().count()
```

```cypher
MATCH ()-[e]->() RETURN count(e)
```

Follow the money: the accounts owned by one company and the transfers those accounts made.

```gremlin
g.V("Company[237]")
  .outE('CompanyOwnAccount').inV()
  .outE('AccountTransferAccount').inV()
  .path()
```

```cypher
MATCH path = (c:Company)-[:CompanyOwnAccount]->(:Account)-[:AccountTransferAccount]->(:Account)
WHERE id(c) = "Company[237]"
RETURN path
```

People born after 1998, the accounts they own and the loans those accounts repaid:

```gremlin
g.V().hasLabel('Person').has('birthday', gt('1998-01-01'))
  .outE('PersonOwnAccount').inV()
  .outE('AccountRepayLoan').inV()
  .path()
```

```cypher
MATCH path = (p:Person)-[:PersonOwnAccount]->(:Account)-[:AccountRepayLoan]->(:Loan)
WHERE p.birthday > '1998-01-01'
RETURN path
```

## Cleanup

- Stop PuppyGraph: `docker stop puppy`.
- In DeltaStream, terminate any query still running (`LIST QUERIES`, then `TERMINATE QUERY`), and drop the tables, streams and stores if you no longer need them.
- In Confluent Cloud, delete the topics with `env $(cat .env | xargs) python produce_data.py -d`, or delete the cluster to stop it consuming credit.
- Drop the tables in Databricks or Snowflake, and empty the S3 prefix if you used Databricks.
