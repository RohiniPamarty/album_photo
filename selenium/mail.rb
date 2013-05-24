require 'mail'
mail = Mail.new do
  from     'rohini@neevtech.com'
  to       'rohini@neevtech.com'
  subject  'Here is the image you wanted'
  body     'This is test'
end

mail.delivery_method :sendmail

mail.deliver
