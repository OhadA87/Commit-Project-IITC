const AWS = require('aws-sdk');

exports.handler = async (event) => {
  const { userName: username } = event.request;

  const authenticated = process.env.AUTHENTICATED === "true";

  if (authenticated) {
    console.log(`Successful authentication for user: ${username}`);
  } else {
    console.error(`Failed authentication for user: ${username}`);
  }

  // Rest of the Lambda function code

  return {
    statusCode: 200,
    body: `Hello, ${username}!`,
  };
};
