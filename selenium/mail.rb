require 'rubygems'
require 'pony'
puts 'sending mail...'
Pony.mail :to => 'rohini@neevtech.com',
          :from => 'rohini@neevtech.com',
          :subject => 'here we get near yeah yeah!',
          :body => 'wsup!'



