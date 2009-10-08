class BaseApiTask

  def do_import(*args)
    options = args.extract_options!
    options[:name]
    counter = 0
    puts "Removing existing docs"
    Document.find_all_by_source(options[:name]).each do |doc|
      puts "#{counter += 1}"
      doc.solr_destroy
      doc.delete
    end

    excluded_url_checker = Proc.new{|url| url.to_s.match(/fr(.*)index.html/).present?}

    counter = 0
    Dir["#{options[:directory]}/**/*.html"].each do |file|
      unless excluded_url_checker.call(file)
        begin
          puts "Processing: #{file}"
          doc = Nokogiri::HTML(open(file))
          title = (doc/"title" ).text
          category = ''
          is_source_code = 'N'
          if title =~ /\AClass\: /
            category = 'api'
          elsif title =~ /\AModule\: /
            category = 'api'
          elsif title =~ /\AFile\: /
            category = 'api'
          else
            if file.match(/[.]src/)
              category = 'src'
              is_source_code = 'Y'
            else
              category = 'doco'
            end
          end

          abstract = (doc/"#description").inner_html
          puts "ABSTRACT: #{abstract}"

          puts "Importing #{counter += 1}:#{file} as #{category}"
          Document.create!(:title => title,
                           :category => category,
                           :file_path => file,
                           :url => file.gsub('public', ''),
                           :source => options[:name],
                           :is_source_code => is_source_code,
                           :abstract => abstract,
                           :content => File.read(file))
        rescue Exception => ex
          puts "FAILED!" + ex
        end
      end
    end


    puts "now processing methods and classes"
    puts "removing existing methods and classes from index"

    counter = 0;
    MethodOrClass.find_all_by_source(options[:name]).each do |doc|
      puts "#{counter += 1}"
      doc.solr_destroy
      doc.delete
    end

    classes_doc = Hpricot(File.new("#{options[:directory]}/fr_class_index.html").read)
    (classes_doc/"#index-entries a").each do |link|
      classname = link.inner_html
      url = link.attributes['href'].strip

      puts classname

      doc = Document.find_by_partial_url(url)
      unless doc.nil?
        puts "Adding #{classname} to index"
        MethodOrClass.new(:is_method => false,
                          :is_class => true,
                          :source => options[:name],
                          :document_id => doc.id,
                          :method_name => nil,
                          :class_name => classname,
                          :url => options[:url_prefix] + url.to_s).save

      end
    end


    methods_doc = Hpricot(File.new("#{options[:directory]}/fr_method_index.html").read)
    (methods_doc/"#index-entries a").each do |link|
      details = link.inner_html

      match = /(.*)(\()(.*)(\))/.match(details)
      methodname = match[1].strip unless match.nil?
      classname = match[3].strip unless match.nil?
      url = link.attributes['href'].strip

      puts methodname + " on " + classname

      doc = Document.find_by_partial_url(url)
      unless doc.nil?
        puts "Adding #{methodname} to index"
        MethodOrClass.new(:is_method => true,
                          :is_class => false,
                          :source => options[:name],
                          :document_id => doc.id,
                          :method_name => methodname,
                          :class_name => classname,
                          :url => options[:url_prefix] + url.to_s).save

      end
    end

    puts "Finished !!"
  end

end