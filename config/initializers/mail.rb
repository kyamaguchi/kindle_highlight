if ENV['SMTP_ADDRESS'].present?
  ActionMailer::Base.smtp_settings = {
    address: ENV.fetch('SMTP_ADDRESS'),
    port: ENV.fetch('SMTP_PORT', 587),
    authentication: ENV.fetch('SMTP_AUTH', :plain),
    user_name: ENV.fetch('SMTP_USERNAME'),
    password: Base64.decode64(ENV.fetch('SMTP_PASSWORD')), # Expect Base64.encode64
    domain: ENV.fetch('SMTP_DOMAIN'),
    enable_starttls_auto: true,
  }
  ActionMailer::Base.default_url_options = { host: ENV.fetch('MAILER_HOST') }
elsif Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '587',
    authentication: :plain,
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_PASSWORD'],
    domain: 'heroku.com',
    enable_starttls_auto: true
  }
  host = "#{ENV['HEROKU_APP_NAME'] || 'myapp'}.herokuapp.com"
  ActionMailer::Base.default_url_options = { host: host }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
  ActionMailer::Base.default_url_options = { host: 'localhost:3000' }
end
