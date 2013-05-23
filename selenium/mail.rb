require 'pony'
Pony.mail(:to => 'rohini@neevtech.com', :from => 'notifications@travis-ci.org', :subject => "hi!", :body => "hello")
