namespace :kindle do
  desc "Fetch kindle highlights"
  task :fetch_highlights, [:limit] => :environment do |t, args|
    limit = (args.limit.presence || 10).to_i
    HighlightFetcher.run(limit: limit)
  end
end
