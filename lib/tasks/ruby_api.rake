require 'hpricot'
require 'open-uri'

ENV['RAILS_ENV'] ||= "development"

namespace :ruby_api do
  desc "Import the Ruby API docs"
  task :import => :environment do
    #Document.delete_all "source = 'Ruby API'"
    counter = 0
    Dir['public/ruby_api/**/*.html' ].each do |file|
      doc = Hpricot(open(file))
      title = (doc/"title" ).text
      category = ''
      if title =~ /\AClass\: /
        category = 'Class'
      elsif title =~ /\AModule\: /
        category = 'Module'
      elsif title =~ /\AFile\: /
        category = 'File'
      else
        if file.match(/[.]src/)
          category = 'Source'
        else
          category = 'Unknown'
        end
      end
      abstract = (doc/"#description").inner_html

      puts "Importing #{counter += 1}:#{file} as #{category}"
      begin
        Document.create!(:title => title,
           :category => category,
           :file_path => file,
           :source => "Ruby_API",
           :abstract => abstract,
           :content => File.read(file))
      rescue
        puts "Failed to import #{file}"
      end
   end
  end
end
