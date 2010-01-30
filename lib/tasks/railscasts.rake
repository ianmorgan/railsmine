require 'hpricot'
require 'open-uri'

ENV['RAILS_ENV'] ||= "development"

namespace :railscasts do
  desc "Import the Railscast "
  task :import => :environment do
    counter = 0
    puts "Removing existing docs"
    Document.find_all_by_source("railscasts").each do |doc|
      puts "#{counter += 1}"
      doc.solr_destroy
      doc.delete
    end

    #crawler = SiteCrawler.new('http://railscasts.com/episodes/archive')
    crawler = SiteCrawler.new('http://railscasts.com/episodes/163-self-referential-association')
    counter = 0
    crawler.crawlSite do |url, page|
      begin
        puts "processing #{url}"
        doc = Hpricot(page)

        category = 'screencast'

        episode_number = (doc/".episodes .episode .side .number").inner_html
        puts episode_number 
        
        not_an_episode_page = url.to_s.match(/episodes\/[0-9]/).nil?
        
        unless episode_number.blank? || not_an_episode_page 
          title = (doc/".episodes .episode .main h2").inner_html
          puts "Add #{title} to index"
          abstract = (doc/".episodes .episode .main .description").inner_html

          puts "Importing #{counter += 1}:#{url} as #{category}"
          Document.create!(:title => title,
                           :category => category,
                           :file_path => 'unknown',
                           :url => url,
                           :source => "railscasts",
                           :is_source_code => 'N',
                           :abstract => abstract,
                           :content => page)
        end
      rescue Exception
        puts "Failed to import #{url}"
      end
    end

  end
end
