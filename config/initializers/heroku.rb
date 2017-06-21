# https://github.com/heroku/heroku-buildpack-google-chrome
if ENV['GOOGLE_CHROME_BIN'].present?
  require "selenium-webdriver"
  chrome_bin = '/app/.apt/usr/bin/google-chrome-stable' # `which google-chrome-stable`
  chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      driver_opts: {args: ["--verbose", "--log-path=chromedriver.log"]},
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
    )
  end
end
