

ENV['RAILS_ENV'] ||= "development"


namespace :railsmine do
  desc "Markup static html content with railsmine header"
  task :markup_html => :environment do
   
    puts 'markup html task called!!' 
    
    puts Dir.pwd
    files = Dir.glob('public/rails_api_233/**/*.html')        
    
    files.each do |f| 
      puts "Updating #{f}"
      content = File.open(f).read
      #puts content
      newcontent = content.gsub('<body>') do |s| 
        '<body><div class="home-page-link"><a href="/">Railsmine.</a><span>Digging for more about Rails...</span></div>'
      end
      #puts newcontent
      File.open(f,'w') do |modified|
        modified.puts newcontent
        modified.close
      end 
    end
    
    puts 'the end'
  end
end
