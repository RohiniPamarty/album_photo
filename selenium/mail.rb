require 'pony'
Pony.mail(:to => 'rohini@neevtech.com', :from => 'rohini@neevtech.com', :subject => "hi!", :body => "hello",:via => :sendmail)
