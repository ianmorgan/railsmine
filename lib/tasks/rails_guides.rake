require 'hpricot'
require 'open-uri'
require 'extras/crawler.rb'

ENV['RAILS_ENV'] ||= "development"

namespace :rails_guides do
  desc "Import the Rails Guides"
  task :import => :environment do
    #Document.delete_all "source = 'RailsAPI'"
    
    crawler = SiteCrawler.new('http://guides.rubyonrails.org')
    
    counter = 0
    crawler.crawlSite do |url,page|
    
      doc = Hpricot(page)
      title = (doc/"title" ).text
      category = 'Documents and Guides'
      
      abstract = (doc/"body").inner_html
      
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
