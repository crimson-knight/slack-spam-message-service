require "../spec_helper.cr"

describe NotificationServices::NotificationHandler do
  incoming_spam_notice_handler = NotificationServices::NotificationHandler.new(json_post_body: %(
    {
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

  incoming_hard_bounce_notice_handler = NotificationServices::NotificationHandler.new(json_post_body: %(
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

  it "processes a spam notification properly" do
    incoming_spam_notice_handler.process_inbound_notification.should eq(true)
  end

  it "properly ignores non-spam notifications" do
    incoming_hard_bounce_notice_handler.process_inbound_notification.should eq(false)
  end
end
