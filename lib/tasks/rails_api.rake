require 'hpricot'
require 'open-uri'

ENV['RAILS_ENV'] ||= "development"

namespace :rails_api do
  desc "Import the Rails API docs"
  task :import => :environment do
    counter = 0
    puts "Removing existing docs" 
    Document.find_all_by_source("rails_api").each do |doc|
       puts "#{counter += 1}"
       doc.solr_destroy
       doc.delete
    end

    counter = 0
    Dir['public/rails_api/**/*.html' ].each do |file|
      doc = Hpricot(open(file))
      title = (doc/"title" ).text
      category = ''
      if title =~ /\AClass\: /
        category = 'api'
      elsif title =~ /\AModule\: /
        category = 'api'
      elsif title =~ /\AFile\: /
        category = 'api'
      else
        category = 'doco'
      end
      
      abstract = (doc/"#description").inner_html
      
      
      puts "Importing #{counter += 1}:#{file} as #{category}"
      Document.create!(:title => title,
        :category => category,
        :file_path => file,
        :url => file.gsub('public',''),
        :source => "rails_api",
        :is_source_code => 'N',
        :abstract => abstract,
        :content => File.read(file))
      end
   end
end
