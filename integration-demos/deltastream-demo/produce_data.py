import argparse
import os
import sys
from pathlib import Path

from confluent_kafka import Producer
from confluent_kafka.admin import AdminClient, NewTopic

TABLES = [
    "Account",
    "AccountRepayLoan",
    "AccountTransferAccount",
    "AccountWithdrawAccount",
    "Company",
    "CompanyApplyLoan",
    "CompanyGuaranteeCompany",
    "CompanyInvestCompany",
    "CompanyOwnAccount",
    "Loan",
    "LoanDepositAccount",
    "Medium",
    "MediumSignInAccount",
    "Person",
    "PersonApplyLoan",
    "PersonGuaranteePerson",
    "PersonInvestCompany",
    "PersonOwnAccount",
]
DATA_DIR = Path(__file__).resolve().parent / "json_data"


def topic_name(table):
    return f"kafka-{table}"


def kafka_config():
    servers = os.environ.get("CONFLUENT_BOOTSTRAP_SERVERS")
    if not servers:
        sys.exit("CONFLUENT_BOOTSTRAP_SERVERS is not set; copy .env.example to .env and fill it in")
    conf = {"bootstrap.servers": servers}
    api_key = os.environ.get("CONFLUENT_API_KEY")
    if api_key:
        conf.update(
            {
                "security.protocol": "SASL_SSL",
                "sasl.mechanisms": "PLAIN",
                "sasl.username": api_key,
                "sasl.password": os.environ.get("CONFLUENT_API_SECRET", ""),
            }
        )
    return conf


def create_topics(conf):
    admin = AdminClient(conf)
    # replication_factor=-1 takes the cluster default: 3 on Confluent Cloud, 1 on a local broker.
    topics = [NewTopic(topic_name(t), num_partitions=1, replication_factor=-1) for t in TABLES]
    for topic, future in admin.create_topics(topics).items():
        try:
            future.result()
            print(f"created {topic}")
        except Exception as e:
            print(f"{topic}: {e}")


def delete_topics(conf):
    admin = AdminClient(conf)
    for topic, future in admin.delete_topics([topic_name(t) for t in TABLES], operation_timeout=30).items():
        try:
            future.result()
            print(f"deleted {topic}")
        except Exception as e:
            print(f"{topic}: {e}")


def produce(conf):
    producer = Producer(conf)
    for table in TABLES:
        topic = topic_name(table)
        count = 0
        with open(DATA_DIR / f"{table}.json", "rb") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                producer.produce(topic, value=line)
                producer.poll(0)
                count += 1
        producer.flush()
        print(f"{topic}: {count} records")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create the demo topics in Confluent Cloud and produce json_data/ into them.")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-c", action="store_true", help="Create the 18 kafka-* topics.")
    group.add_argument("-s", action="store_true", help="Produce every record in json_data/ into its topic.")
    group.add_argument("-d", action="store_true", help="Delete the 18 kafka-* topics.")
    args = parser.parse_args()

    conf = kafka_config()
    if args.c:
        create_topics(conf)
    elif args.s:
        produce(conf)
    elif args.d:
        delete_topics(conf)
