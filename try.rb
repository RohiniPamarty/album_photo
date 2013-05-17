require 'rubygems'
require 'selenium-webdriver'
wd = Selenium::WebDriver.for :firefox

wd.get "https://www.google.co.in/search?client=ubuntu&channel=fs&q=sauce+travis+rspec&ie=utf-8&oe=utf-8&redir_esc=&ei=2dOVUaGKJJHrrQeZtIHgAw"
wd.quit
