class HighlightFetcher

  def self.run
    last_id = Highlight.last.id
    fetch_highlight

    last_id_after_fetch = Highlight.last.id

    if last_id_after_fetch.to_i > last_id.to_i
      Notifier.summary(Book.recent).deliver_now
    else
      Rails.logger.info "No change of highlights"
    end
  end

  def self.fetch_highlight
    raise "Login information for amazon needs to be defined in .env. Please run $ rake kindle:login_vars" if ENV['AMAZON_USERNAME_CODE'].blank? || ENV['AMAZON_PASSWORD_CODE'].blank?
    k = Kindle::Highlights.new(login: ENV['AMAZON_USERNAME_CODE'], password: ENV['AMAZON_PASSWORD_CODE'], convert: true)
    k.fetch_highlights.group_by(&:asin).each do |asin, highlights|
      title = highlights.first.title
      Rails.logger.info "Saving #{title} http://www.amazon.co.jp/gp/product/#{asin}/"
      book = Book.where(asin: asin).first_or_create! do |b|
        Rails.logger.info "Creating #{title}"
        b.title = title
        b.author = highlights.first.author
      end
      book.update_attribute(:last_annotated_on, highlights.first.last_annotated_on)
      highlights.each do |h|
        book.highlights.where(content: h.highlight).first_or_create! do |obj|
          obj.location = h.location
          obj.annotation_id = h.id
          obj.note = h.note
          obj.note_id = h.note_id
          obj.fetched_at = Time.now
        end
      end
    end
  end
end
