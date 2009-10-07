require 'hpricot'
require 'open-uri'
require 'app/extras/base_api_task.rb'


ENV['RAILS_ENV'] ||= "development"

namespace :ruby_api do
  desc "Import the Ruby API docs"
  task :import => :environment do
      importer = BaseApiTask.new
      importer.do_import(:name => 'ruby_api',
                         :directory => 'public/ruby_api',
                         :url_prefix => '/ruby_api/')
  end

end
