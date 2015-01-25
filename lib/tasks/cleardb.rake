require "database_cleaner"

namespace :db do
  task :clear => :environment do

    DatabaseCleaner.strategy = :truncation#, {:except => %w[industries offers]} 

    DatabaseCleaner.clean

  end
end