class MethodOrClass < ActiveRecord::Base
  belongs_to :document
  acts_as_solr

  def MethodOrClass.delete_all
     MethodOrClass.find(:all).each do |mc|
         puts "Deleting record: #{mc.id}"
         mc.solr_destroy
         mc.delete
     end
  end
end
