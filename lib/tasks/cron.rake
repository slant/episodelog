desc "Look for and add new episodes"
task :cron => :environment do
  Import::Content.new.start
end