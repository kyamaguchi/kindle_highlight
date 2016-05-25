if ENV['CHROME']
  Capybara.register_driver :selenium do |app|
    # http://chromedriver.storage.googleapis.com/index.html
    # Download latest chromedriver_xxx.zip
    # sudo mv ~/Downloads/chromedriver /usr/local/bin/
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  Capybara.javascript_driver = :selenium
elsif ENV['SELENIUM']
  Capybara.javascript_driver = :selenium
else
  Capybara.javascript_driver = :webkit
end

def selenium?
  Capybara.current_driver == :selenium
end
