class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_TO'] || ENV['AMAZON_USERNAME'] || "from@heroku.com"
  layout 'mailer'
end
