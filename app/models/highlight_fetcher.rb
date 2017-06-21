class HighlightFetcher

  def self.run(options = {})
    last_id = Highlight.last.id
    fetch_highlight(options)

    last_id_after_fetch = Highlight.last.id

    if last_id_after_fetch.to_i > last_id.to_i
      Notifier.summary(Book.recent).deliver_now
    else
      Rails.logger.info "No change of highlights"
    end
  end

  def self.fetch_highlight(options = {})
    client = KindleManager::Client.new(options.reverse_merge(debug: true, limit: 10, driver: :chrome))
    client.fetch_kindle_highlights
    books = client.load_kindle_highlights

    books.each do |fetched|
      asin = fetched.asin
      title = fetched.title
      Rails.logger.info "Saving #{title} http://www.amazon.co.jp/gp/product/#{asin}/"
      book = Book.where(asin: asin).first_or_create! do |b|
        Rails.logger.info "Creating #{title}"
        b.title = title
        b.author = fetched.author
      end
      book.update_attribute(:last_annotated_on, fetched.last_annotated_on)
      fetched.highlights_and_notes.each do |h|
        content = h['highlight'].presence || h['note']
        book.highlights.where(content: content).first_or_create! do |obj|
          obj.location = h['location']
          obj.note = h['note']
          obj.color = h['color']
          obj.fetched_at = Time.current
        end
      end
    end
  end
end
