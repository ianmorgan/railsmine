class MethodOrClass < ActiveRecord::Base
  belongs_to :document
  acts_as_solr
end
