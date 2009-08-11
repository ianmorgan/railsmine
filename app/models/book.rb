class Book < ActiveRecord::Base
  acts_as_solr :facets => [:publisher] 
  has_and_belongs_to_many :categories
end