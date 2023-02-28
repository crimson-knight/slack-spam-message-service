require "json"

# This is the primary class for taking in the JSON that will be used to determine the next actions to perform.
class NotificationServices::NotificationHandler
  property incoming_notification : NotificationServices::IncomingNotification

  def initialize(json_post_body)
    @incoming_notification = NotificationServices::IncomingNotification.from_json(json_post_body)
  end

  # Add/adjust the logic here for how to handle message types
  def process_inbound_notification : Bool
    case @incoming_notification
    when .is_a_spam_notification?
      {% if !@top_level.has_constant? "Spec" %}
        SpamNotificationWorker.new(notification_to_send_to_slack: @incoming_notification.to_json.to_s).enqueue
      {% end %}
      true
    else
      false
    end
  end
end
