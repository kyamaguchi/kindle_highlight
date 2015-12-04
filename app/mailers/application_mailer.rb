class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_FROM'] || Kindle::Converter.decode(ENV['AMAZON_USERNAME_CODE']) || "from@heroku.com"
  layout 'mailer'
end
