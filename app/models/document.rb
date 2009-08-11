class Document < ActiveRecord::Base
  acts_as_solr :facets => [:category, :source]
  
  def path_to_source
    "/" + source.downcase.gsub(' ', '_').gsub('public','')
  end
  
end
