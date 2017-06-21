class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_FROM'] || ENV['ERROR_MAIL_TO'] || "from@heroku.com"
  layout 'mailer'
end
