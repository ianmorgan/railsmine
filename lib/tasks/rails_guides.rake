require 'hpricot'
require 'open-uri'
require 'extras/crawler.rb'

ENV['RAILS_ENV'] ||= "development"

namespace :rails_guides do
  desc "Import the Rails Guides"
  task :import => :environment do
    
    counter = 0
    puts "Removing existing docs" 
    Document.find_all_by_source("Rails_Guides").each do |doc|
       puts "#{counter += 1}"
       doc.solr_destroy
       doc.delete
    end
    
    crawler = SiteCrawler.new('http://guides.rubyonrails.org')
    
    counter = 0
    crawler.crawlSite do |url,page|
    
      doc = Hpricot(page)
      title = (doc/"title" ).text
      category = 'Documents and Guides'
    
      abstract = (doc/"#feature .wrapper  p").inner_html
      #puts abstract

      puts "Importing #{counter += 1}:#{url} as #{category}"
      Document.create!(:title => title,
        :category => category,
        :file_path => 'unknown',
        :source => "Rails_Guides",
        :abstract => abstract,
        :content => page)
      end
   end
end
