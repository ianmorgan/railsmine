require 'hpricot'
require 'open-uri'

ENV['RAILS_ENV'] ||= "development"

namespace :rails_api do
  desc "Import the Rails API docs"
  task :import => :environment do
    #Document.delete_all "source = 'RailsAPI'"
    counter = 0
    Dir['public/rails_api/**/*.html' ].each do |file|
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
        category = 'Unknown'
      end
      
      abstract = (doc/"#description").inner_html
      
      puts "Importing #{counter += 1}:#{file} as #{category}"
      Document.create!(:title => title,
        :category => category,
        :file_path => file,
        :source => "Rails_API",
        :abstract => abstract,
        :content => File.read(file))
      end
   end
end
