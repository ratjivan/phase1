const { SQSClient, SendMessageCommand } = require("@aws-sdk/client-sqs");

const client = new SQSClient({});

exports.handler = async (event) => {

    const message = {
        reportId: "1001",
        customer: "John Doe",
        amount: 5000,
        status: "SUCCESS"
    };

    await client.send(
        new SendMessageCommand({
            QueueUrl: process.env.QUEUE_URL,
            MessageBody: JSON.stringify(message)
        })
    );

    return {
        statusCode: 200,
        body: JSON.stringify({
            message: "Message sent"
        })
    };
};