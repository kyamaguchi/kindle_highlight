if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
  host = "#{ENV['HEROKU_APP_NAME'] || 'myapp'}.herokuapp.com"
  ActionMailer::Base.default_url_options = { host:host }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
  ActionMailer::Base.default_url_options = { host:'localhost:3000' }
end
