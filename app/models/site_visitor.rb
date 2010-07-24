class SiteVisitor < ActiveRecord::Base
  has_many :site_visitor_history do
 
    def latest_5_searches 
      parent_id = proxy_owner.id
      find(:all,
           :limit => 5,
           :order => 'created_at DESC',
           :conditions => ["site_visitor_id = ?", parent_id ]) 
    end 
    
     def latest_searches 
          parent_id = proxy_owner.id
          find(:all,
               :limit => 100,
               :order => 'created_at DESC',
               :conditions => ["site_visitor_id = ?", parent_id ]) 
    end 
  end

  def SiteVisitor.generate_unique_cookie
     (0...10).map{ ('a'..'z').to_a[rand(26)] }.join 
  end
end
