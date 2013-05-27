

require 'net/smtp'

message = <<MESSAGE_END
From: Private Person <rohini@neevtech.com>
To: A Test User <rohini@neevtech.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

output1 = Net::SMTP.start('mail.travis-ci.org') do |smtp|
  smtp.send_message message, 'rohini@neevtech.com', 
                             'rohini@neevtech.com'
end
puts "#{output1}"
