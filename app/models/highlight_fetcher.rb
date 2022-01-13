class HighlightFetcher

  def self.run(options = {})
    last_id = Highlight.last&.id || 0
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
    load_session_from_db(client.session)

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

    keep_session_in_db(client.session)
    client
  end

  def self.keep_session_in_db(session)
    puts "Storing cookie data into database"
    ## data with Marshal.dump causes db error
    data = session.driver.browser.manage.all_cookies
    puts data.inspect
    store = DataStore.where(key: key_for_cookie).first_or_create
    store.update!(content: data)
  end

  def self.load_session_from_db(session)
    if (store = DataStore.find_by_key(key_for_cookie)) && store.content.present?
      puts "Loading cookie data from database"
      ## visit is required before touching cookie
      session.visit "https://www.#{AmazonInfo.domain}/" unless session.current_url =~ /\Ahttp/

      store.content.each do |d|
        ## :name needs to be symbol on 'add_cookie'
        d.symbolize_keys!
        d[:expires] = Time.parse(d[:expires]) if d[:expires]
        puts d.inspect
        begin
          session.driver.browser.manage.add_cookie d
        rescue => e
          puts e.message
          session.skip_invalid_cookie_domain_error(e)
        end
      end
      puts "Loaded cookie data from database"
      session.visit session.current_url
    else
      puts "Cookie data doesn't exist in database"
    end
  end

  def self.clear_cookie
    DataStore.find_by_key(key_for_cookie)&.delete
  end

  def self.key_for_cookie
    'all_cookies'
  end
end
