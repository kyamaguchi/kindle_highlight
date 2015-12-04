namespace :kindle do
  desc "Fetch kindle highlights"
  task :fetch_highlights => :environment do
    HighlightFetcher.run
  end

  desc "Generate login"
  task :login_vars => :environment do
    system('`bundle show kindle`/bin/convert_login')
  end
end
