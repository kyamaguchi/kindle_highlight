class Notifier < ApplicationMailer
  def summary(books)
    @books = books
    mail_to = ENV['MAIL_TO'].presence || ENV['AMAZON_USERNAME']
    if mail_to.present?
      mail(to: mail_to)
    else
      Rails.logger.error("ENV['MAIL_TO'] or ENV['AMAZON_USERNAME'] is not defined.")
    end
  end
end
