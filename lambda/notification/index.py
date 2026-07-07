import json
import boto3
import os
from datetime import datetime

s3 = boto3.client("s3")

BUCKET_NAME = os.environ.get("BUCKET_NAME")


def lambda_handler(event, context):

    report = {
        "status": "SUCCESS",
        "processedAt": datetime.utcnow().isoformat(),
        "input": event
    }

    file_name = f"reports/report-{datetime.utcnow().strftime('%Y%m%d%H%M%S')}.json"

    s3.put_object(
        Bucket=BUCKET_NAME,
        Key=file_name,
        Body=json.dumps(report, indent=2),
        ContentType="application/json"
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Report stored in S3",
            "file": file_name
        })
    }