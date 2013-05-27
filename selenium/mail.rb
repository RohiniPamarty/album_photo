out = require 'pony'
puts "#{out}"
#ouput = Pony.mail(:to => 'rohini@neevtech.com', :from => 'rohini@neevtech.com', :subject => "hi!", :body => "hello",:via => :sendmail)



ouput = Pony.mail({
  :to => 'rohini@neevtech.com',
  :from => 'rohini@neevtech.com', 
  :subject => "hi!", 
  :body => "test_result #{ARGV[0]}",
  :attachments => {"result.txt" => File.read("result.txt")},
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'rohini@neevtech.com',
    :password             => 'ponytest',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => ENV["HOSTNAME"] # the HELO domain provided by the client to the server
  }
})
puts "#{ouput}"
