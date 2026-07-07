const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");

const client = new S3Client({});

exports.handler = async (event) => {

    const file = `report-${Date.now()}.json`;

    await client.send(
        new PutObjectCommand({
            Bucket: process.env.BUCKET_NAME,
            Key: file,
            Body: JSON.stringify(event)
        })
    );

    return {
        statusCode: 200,
        body: JSON.stringify({
            message: "Stored in S3",
            file: file
        })
    };

};