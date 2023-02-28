require "json"

class NotificationServices::IncomingNotification
  include JSON::Serializable

  @[JSON::Field(key: "RecordType")]
  property record_type : String

  @[JSON::Field(key: "Type")]
  property type : String

  @[JSON::Field(key: "TypeCode")]
  property type_code : Int32

  @[JSON::Field(key: "Name")]
  property name : String

  @[JSON::Field(key: "Tag")]
  property tag : String

  @[JSON::Field(key: "MessageStream")]
  property message_stream : String

  @[JSON::Field(key: "Description")]
  property description : String

  @[JSON::Field(key: "Email")]
  property email : String

  @[JSON::Field(key: "From")]
  property from : String

  @[JSON::Field(key: "BouncedAt")]
  property bounced_at : Time

  def is_a_spam_notification?
    @type.matches?(/SpamNotification/i)
  end

  def generate_slack_message
    <<-STRING
    {
      "text": "#{@description}",
      "blocks": [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": ""
          }
        }
      ]
    }
    STRING
  end
end
