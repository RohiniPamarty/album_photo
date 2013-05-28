out = require 'pony'
puts "#{out}"
#ouput = Pony.mail(:to => 'rohini@neevtech.com', :from => 'rohini@neevtech.com', :subject => "hi!", :body => "hello",:via => :sendmail)



ouput = Pony.mail({
  :to => 'rohini@neevtech.com',
  :from => 'rohini@neevtech.com', 
  :subject => "Test Result from Travis", 
  :body => "Please find the test result in the enclosed attachment with this mail. ",
  :attachments => {"result.txt" => File.read("result.txt")},
  :via => :sendmail,
  :via_options => {
    :location  => '/usr/sbin/sendmail', # defaults to 'which sendmail' or '/usr/sbin/sendmail' if 'which' fails
    :arguments => '' # -t and -i are the defaults
  }
})
puts "#{ouput}"
