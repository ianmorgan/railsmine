class Document < ActiveRecord::Base
  acts_as_solr :facets => [:category, :source, :is_source_code]
  
  def path_to_source
    "/" + source.downcase.gsub(' ', '_').gsub('public','')
  end
  
  def category_full_name
    Document.category_full_name(category)
  end
  
  def Document.category_full_name(category)
      {'src' => 'Source',
       'doco' => 'Documentation and Guides',
       'api' => 'API'}[category]
  end
  
  
  def Document.source_full_name(source)
        {'rails_api' => 'Rails API',
         'ruby_api' => 'Ruby API',
         'rails_guides' => 'Rails Guides'}[source]
   end
   
   
  def Document.testing  
    Document.find_by_solr("rails", 
       :facets => {:zeros => false, 
                   :sort => true,
                   :aaquery => "source:api",
                   :browse => ["is_source_code:Y"],
                   :fields => [:category, :source]})
  end
  
end
