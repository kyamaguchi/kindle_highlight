if ENV['ERROR_MAIL_TO']
  Rails.application.config.middleware.use ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[#{ENV['HEROKU_APP_NAME']} ERROR] ",
      :sender_address => ENV['ERROR_MAIL_TO'],
      :exception_recipients => [ENV['ERROR_MAIL_TO']]
    }
end
