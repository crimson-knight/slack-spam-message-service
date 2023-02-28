require "../spec_helper.cr"

describe NotificationServices::IncomingNotification do
  incoming_spam_notice = NotificationServices::IncomingNotification.from_json(%({
      "RecordType": "Bounce",
      "Type": "SpamNotification",
      "TypeCode": 512,
      "Name": "Spam notification",
      "Tag": "",
      "MessageStream": "outbound",
      "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
      "Email": "zaphod@example.com",
      "From": "notifications@honeybadger.io",
      "BouncedAt": "2023-02-27T21:41:30Z"
    }
  ))

  incoming_hard_bounce_notice = NotificationServices::IncomingNotification.from_json(%(
    {
      "RecordType": "Bounce",
      "MessageStream": "outbound",
      "Type": "HardBounce",
      "TypeCode": 1,
      "Name": "Hard bounce",
      "Tag": "Test",
      "Description": "The server was unable to deliver your message (ex: unknown user, mailbox not found).",
      "Email": "arthur@example.com",
      "From": "notifications@honeybadger.io",
      "BouncedAt": "2019-11-05T16:33:54.9070259Z"
    }
  ))

  it "creates an object from a valid JSON payload" do
    incoming_spam_notice.should be_a(NotificationServices::IncomingNotification)
  end

  it "properly verifies a SpamNotification" do
    incoming_hard_bounce_notice.is_a_spam_notification?.should eq(false)
    incoming_spam_notice.is_a_spam_notification?.should eq(true)
  end
end
