require 'hpricot'
require 'open-uri'

ENV['RAILS_ENV'] ||= "development"

namespace :ruby_api do
  desc "Import the Ruby API docs"
  task :import => :environment do
  
    counter = 0
    puts "Removing existing docs" 
    Document.find_all_by_source("ruby_api").each do |doc|
       puts "#{counter += 1}"
       doc.solr_destroy
       doc.delete
    end

    counter = 0
    Dir['public/ruby_api/**/*.html' ].each do |file|
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
        if file.match(/[.]src/)
          category = 'src'
        else
          category = 'doco'
        end
      end
      abstract = (doc/"#description").inner_html

      puts "Importing #{counter += 1}:#{file} as #{category}"
      begin
        Document.create!(:title => title,
           :category => category,
           :file_path => file,
           :url => file.gsub('public',''),
           :source => "ruby_api",
           :abstract => abstract,
           :content => File.read(file))
      rescue
        puts "Failed to import #{file}"
      end
   end
  end
end
