require 'net/smtp'

message = <<MESSAGE_END
From: Private Person <rohini@neevtech.com>
To: A Test User <rohini@neevtech.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'rohini@neevtech.com', 
                             'rohini@neevtech.com'
end
