#relevant test::unit requires
gem 'test-unit'
require 'test/unit'
require 'test/unit/testsuite' 
#require 'test/unit/ui/console/testrunner'

#TestCase classes that contain the methods I want to execute
require_relative 'MyTestClass'

#create a new empty TestSuite, giving it a name
my_tests = Test::Unit::TestSuite.new("My Special Tests")

#add the test method called 'test_one' defined
#in the TestOne TestCase class to the my_tests
#test suite defined above
my_tests << MyTestClass.new('test2')

#run the suite
#Test::Unit::UI::Console::TestRunner.run(my_tests)
