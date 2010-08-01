require 'nokogiri'
require 'open-uri'
require 'app/extras/base_api_task.rb'


ENV['RAILS_ENV'] ||= "development"

class RailsApiImporter < BaseApiTask
end

namespace :rails_api do
  desc "Import the Rails API docs"
  task :import => :environment do
   importer = RailsApiImporter.new
   importer.do_import(:name => 'rails_api',
                      :directory => 'public/rails_api',
                      :url_prefix => '/rails_api/')
  end
end
