namespace :kindle do
  desc "Fetch kindle highlights"
  task :fetch_highlights, [:limit] => :environment do |t, args|
    limit = (args.limit.presence || 10).to_i
    HighlightFetcher.run(limit: limit)
  end

  desc "Clear cookie in db"
  task :clear_cookie => :environment do |t, args|
    HighlightFetcher.clear_cookie
  end
end
