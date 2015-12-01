namespace :kindle do
  desc "Fetch kindle highlights"
  task :fetch_highlights => :environment do
    HighlightFetcher.run
  end
end
