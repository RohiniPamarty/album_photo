gem 'test-unit'
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
    caps = Selenium::WebDriver::Remote::Capabilities.browserType
    caps.platform = 'Linux'
    caps.version = '17'
    username = ENV['SAUCE_USERNAME']
    key = ENV['SAUCE_ACCESS_KEY']
    hub_url = "http://#{username}:#{key}@ondemand.saucelabs.com:80/wd/hub" 
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
          return @myParent.get_now().find_element(:id,@myBy)
        end
        return @myParent.get_now().find_element(:id,@myBy)
      end
      if(@myIndex != nil)
        return @myDriver.find_element(:id, @myBy)
      end
      return @myDriver.find_element(:id, @myBy)
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
