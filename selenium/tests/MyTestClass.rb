require 'rubygems'
require "selenium-webdriver"
require 'sqlite3'
require 'test/unit'
include Test::Unit::Assertions
class SeleniumTestBase < Test::Unit::TestCase
  def initialize(webDriver)
    @myDriver = webDriver
  end
  def get_data(connString, sql)
    db =connString
    db.execute sql
    #Some code which will query a DB for you
  end
  def start_browser(browserType)
    caps = Selenium::WebDriver::Remote::Capabilities.firefox
    username = ENV['SAUCE_USERNAME']
    key = ENV['SAUCE_ACCESS_KEY']
    hub_url = "http://#{username}:#{key}@ondemand.saucelabs.com:80" 
    return @myDriver = @myDriver.for(:remote, :url => hub_url, :desired_capabilities => caps)
    #Some code which will launch different types of browsers
  end
  def switch_to_window(handle)
    @myDriver.switch_to.window handle
    #Some code which will switch windows for you
  end
  def switch_to_frame(handle)
    @myDriver.switch.frame handle
    #Some code which will switch frames for you
  end
  def launch_url(url)    
    @myDriver.navigate.to(url)
    #Some code which will navigate directly to the specified URL.
  end
  def refresh
    @myDriver.get @myDriver.url
    #Some code to refresh the page you are currently on
  end
end
class SeleniumActionBase < Test::Unit::TestCase
  def initialize(webDriver)
    @myDriver = webDriver
  end
  def execute_sql(connString, sql = "", sp_name = "", parameters =[])
    #Some code which will execute a query or stored proceedure for you
  end
  def switch_to_window(handle)
    #Some code which will switch windows for you
  end
  def switch_to_frame(handle)
    #Some code which will switch frames for you
  end
  def launch_url(url)
    #Some code which will navigate directly to the specified URL.
  end
  def refresh()
    #Some code to refresh the page you are currently on
  end
end

class SeleniumPageBase 
  attr_reader :browserIndex
  def initialize(webDriver)
    @myDriver = webDriver
  end
end
class SeleneniumPageElement 
  attr_reader :myBy, :myDriver, :myIndex, :myParent
  attr_writer :myBy, :myDriver, :myIndex, :myParent
  def initialize(locator, webDriver, parent = nil, index = nil)
    @myBy = locator
    @myDriver = webDriver
    @myIndex = index
    @myParent = parent
  end
  def get_now(errorMessage = "")
    begin
      if(@myParent != nil)
        if(@myIndex != nil)
          return @myParent.get_now().find_element(:id,@myBy);
        end
        return @myParent.get_now().find_element(:id,@myBy);
      end
      if(@myIndex != nil)
        return @myDriver.find_element(:id, @myBy);
      end
      return @myDriver.find_element(:id, @myBy);
    rescue  Exception=>e
      raise e
    end
    
  end
  def waiting_get(seconds = 5, errorMessage = "")
    #Waiting function using above method. 
  end
  def click(seconds = 5, errorMessage = "")
    waiting_get(seconds, errorMessage).click();
  end
end

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
      return @loginpage.confirmationMessage
    end
    if(isValid != nil && isValid == false)
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
  def test
    @instance_sucess = LoginTests.new(Selenium::WebDriver)
    assert(@instance_sucess.successful_login_test)
  end
  def test2
    @instance_failure = LoginTests.new(Selenium::WebDriver)
    assert(@instance_failure.unsuccessful_login_test)
  end
end
