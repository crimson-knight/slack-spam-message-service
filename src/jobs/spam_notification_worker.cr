require "http/client"

class SpamNotificationWorker < Mosquito::QueuedJob
  params notification_to_send_to_slack : String

  def perform
    spam_notification = NotificationServices::IncomingNotification.from_json(JSON.parse(notification_to_send_to_slack))

    reponse = HTTP::Client.post(ENV["SLACK_CHANNEL_WEBHOOK"], headers: HTTP::Headers{"Content-type" => "application/json"}, body: spam_notification.generate_slack_message)

    raise "Slack API returned a non-200 status code." if ![200, 201].includes?(response.status_code)
  end
end
