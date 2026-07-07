{
  "Comment": "Account Reconciliation Workflow",
  "StartAt": "Notification",

  "States": {

    "Notification": {

      "Type": "Task",

      "Resource": "${notification_lambda}",

      "End": true

    }

  }

}