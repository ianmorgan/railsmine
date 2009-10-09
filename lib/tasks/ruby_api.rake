require 'nokogiri'
require 'open-uri'
require 'app/extras/base_api_task.rb'


ENV['RAILS_ENV'] ||= "development"

namespace :ruby_api do
  desc "Import the Ruby API docs"
  task :import_186 => :environment do
      importer = BaseApiTask.new
      importer.do_import(:name => 'ruby_api_186',
                         :directory => 'public/ruby_api_186',
                         :url_prefix => '/ruby_api_186/')
  end

end
