import json
import boto3
import os
import uuid
from datetime import datetime

sqs = boto3.client("sqs")

QUEUE_URL = os.environ.get("QUEUE_URL")


def lambda_handler(event, context):

    body = {
        "requestId": str(uuid.uuid4()),
        "customer": "ABC Bank",
        "reportType": "Account Reconciliation",
        "generatedAt": datetime.utcnow().isoformat()
    }

    sqs.send_message(
        QueueUrl=QUEUE_URL,
        MessageBody=json.dumps(body)
    )

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "message": "Message successfully sent to SQS",
            "data": body
        })
    }