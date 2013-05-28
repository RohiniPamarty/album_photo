require 'rubygems'
require "selenium-webdriver"
require 'sqlite3'
require 'test/unit'
require_relative 'selenium_base'
include Test::Unit::Assertions


class ProjectTestBase < SeleniumTestBase 
  def initialize(webDriver)
    super(webDriver)
  end
  def create_actions(webDriver)
    @loginActions = LoginActions.new(webDriver)
  end
  def create_pages(webDriver)
    @loginPage = LoginPage.new(webDriver)
  end
  def self.setup_test_fixture
    #Function is virtual so child test classes can have additional functionality.Function is virtual so child test classes can have additional functionality.
    #For this example project, nothing needs to be done on this level.
  end
  def setup
    @selenium_test_base = SeleniumTestBase.new(@myDriver)
    @myDriver = @selenium_test_base.start_browser("firefox")
    @selenium_test_base.launch_url("http://ec2-184-73-243-249.compute-1.amazonaws.com/users/sign_in")
    create_actions(@myDriver)
    create_pages(@myDriver)

  end
  def tear_down(webDriver)  
    webDriver.quit
  end
  def self.setup_test_fixture
    #Function is virtual so child test classes can have additional functionality.
    #For this example project, nothing needs to be done on this level.
  end
end


class ProjectActionBase < SeleniumActionBase
  def initialize(webDriver)
    super(webDriver)
    @loginPage = LoginPage.new(webDriver);
  end
end

class LoginActions < ProjectActionBase
  def login_attempt(username, password, isValid = nil)
    @loginpage = LoginPage.new(@myDriver)
    @loginpage.usernameTextField.clear()
    @loginpage.usernameTextField.send_keys(username)
    @loginpage.passwordTextField.clear()
    @loginpage.passwordTextField.send_keys(password)
    @loginpage.passwordTextField.submit
    if(isValid != nil && isValid == true) 
      @myDriver.manage.timeouts.implicit_wait = 10    
      return @loginpage.confirmationMessage
    end
    if(isValid != nil && isValid == false)
      @myDriver.manage.timeouts.implicit_wait = 10    
      return @loginpage.errorMessage
    end
    #@loginpage.submit    
  end
end

class LoginPage < SeleniumPageBase 
  #class << self; attr_accessor :usernameTextField,:passwordTextField  end
  attr_reader :usernameTextField, :passwordTextField, :confirmationMessage, :errorMessage
  def initialize(webDriver)
    super(webDriver) 
    @usernameTextField = SeleneniumPageElement.new("user_login",@myDriver).get_now
    @passwordTextField= SeleneniumPageElement.new("user_password",@myDriver).get_now
    @confirmationMessage= SeleneniumPageElement.new("flash-notice", @myDriver)
    @errorMessage= SeleneniumPageElement.new("flash-alert", @myDriver)
    #    @usernameTextField = @myDriver.find_element(:id, "user_login")#.new(By.Name("user_login"), webDriver)
    #    @passwordTextField= @myDriver.find_element(:id, "user_password")#.new(By.Name("user_password"), webDriver)
    #    @submitbutton = @myDriver.find_element(:name, "commit")
  end
end


class LoginTests < ProjectTestBase
  def successful_login_test
    setup
    @loginactions=LoginActions.new(@myDriver) 
    output = assert_equal @loginactions.login_attempt("mandar","password", true).get_now.text,"Signed in successfully."
    tear_down(@myDriver)
    return output
    
  end  
  def unsuccessful_login_test
    setup
    @loginactions=LoginActions.new(@myDriver) 
    output = assert_equal @loginactions.login_attempt("abc","abc", false).get_now.text,"Invalid email or password."
    tear_down(@myDriver)
    return output
    
  end
end


class MyTestClass < Test::Unit::TestCase  
#  def test
#    @instance_sucess = LoginTests.new(Selenium::WebDriver)
#    assert(@instance_sucess.successful_login_test)
#  end
  def test2
    @instance_failure = LoginTests.new(Selenium::WebDriver)
    assert(@instance_failure.unsuccessful_login_test)
  end
end
