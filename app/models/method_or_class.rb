class MethodOrClass < ActiveRecord::Base
  belongs_to :document
  acts_as_solr :facets => [:source]

  def MethodOrClass.delete_everything
     MethodOrClass.find(:all).each do |mc|
         puts "Deleting record: #{mc.id}"
         mc.solr_destroy
         mc.delete
     end
  end
end
