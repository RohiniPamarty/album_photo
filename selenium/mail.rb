out = require 'pony'
puts "#{out}"
#ouput = Pony.mail(:to => 'rohini@neevtech.com', :from => 'rohini@neevtech.com', :subject => "hi!", :body => "hello",:via => :sendmail)



ouput = Pony.mail({
  :to => 'rohini@neevtech.com',
  :from => 'rohini@neevtech.com', 
  :subject => "hi!", 
  :body => "test_result #{ARGV[0]}, branch #{ARGV[1]}, build directory #{ARGV[2]}, build id #{ARGV[3]}, build number #{ARGV[4]}, commit #{ARGV[5]}, commit range #{ARGV[6]}, job id #{ARGV[7]}, job number #{ARGV[8]}, pull request #{ARGV[9]}, secure environment variables #{ARGV[10]}, repo slug #{ARGV[11]}",
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
