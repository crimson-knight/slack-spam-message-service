# slack_spam_notification_service
 A simple but effective notification service to relay spam messages into a slack channel.

 This provides a single end-point that accepts incoming JSON payloads and if a message worth passing onto slack is found, a background job will be enqueued through Redis.

 This allows for web requests to be speedy logic checks and the actual message sending to be decoupled. This way, if Slack's webhooks API returns errors or is slow to respond, whatever service is sending the messages will not be affected. Background jobs that fail also have exponential back-off and automatic retries, and dead jobs are available in Redis for analytics if any debugging information is desired.


 Requirements:
 Crystal (latest)
 Redis

 Environment variables required:
 `REDIS_URL`
 `SLACK_CHANNEL_WEBHOOK`


- [Seth Tucker](https://github.com/crimson-knight) - creator and maintainer
