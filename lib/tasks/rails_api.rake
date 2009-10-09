require 'nokogiri'
require 'open-uri'
require 'app/extras/base_api_task.rb'


ENV['RAILS_ENV'] ||= "development"

class RailsApiImporter < BaseApiTask
end

namespace :rails_api do
  desc "Import the Rails API docs"
  task :import_233 => :environment do
   importer = RailsApiImporter.new
   importer.do_import(:name => 'rails_api_233',
                      :directory => 'public/rails_api_233',
                      :url_prefix => '/rails_api_233/')
  end
end
