if Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
end
