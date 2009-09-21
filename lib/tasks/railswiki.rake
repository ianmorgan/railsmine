require 'hpricot'
require 'open-uri'

ENV['RAILS_ENV'] ||= "development"

namespace :railswiki do
  desc "Import the Rails WIKI"
  task :import => :environment do
    counter = 0
    puts "Removing existing docs"
    Document.find_all_by_source("railswik").each do |doc|
      puts "#{counter += 1}"
      doc.solr_destroy
      doc.delete
    end

    url_checker = Proc.new{|url| url.to_s.match(/wiki.rubyonrails.org\/(de|el|es|fr|he|it|ja|ko|lt|pt|th|tr|zh)\//).nil?}

    crawler = SiteCrawler.new('http://wiki.rubyonrails.org', url_checker)
    counter = 0
    crawler.crawlSite do |url, page|
      begin
        puts "processing #{url}"
        doc = Hpricot(page)

        category = 'doco'

          title = (doc/".page h1 a").inner_html
          abstract = (doc/".page .level1").inner_html

          puts title
          puts "Importing #{counter += 1}:#{url} as #{category}"
          Document.create!(:title => title,
                           :category => category,
                           :file_path => 'unknown',
                           :url => url,
                           :source => 'railswiki',
                           :is_source_code => 'N',
                           :abstract => abstract,
                           :content => page)

      rescue Exception
        puts "Failed to import #{url}"
      end
    end

  end
end
