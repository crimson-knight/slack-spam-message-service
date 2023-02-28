require "kemal"
require "mosquito"
require "./jobs/**"
require "./notification_services/**"

# This is the main entry-point for the Slack Spam Notification Service. This service runs using Kemal (a sinatra-like web framework built in Crystal).
module SlackSpamNotificationService
  post "/incoming_notifications/create" do |request|
    begin
      NotificationServices::NotificationHandler.new(json_post_body: request.params.json).process_inbound_notification
      env.response.status_code = 200
    rescue
      env.response.status_code = 400
    end
  end

  Kemal.run
end
