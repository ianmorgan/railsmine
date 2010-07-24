#---
# Excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
class SearchHistoryController < ApplicationController
  
  layout "public"
  
  def latest
     visitor_cookie = cookies[:railsmine_visitor]
     if visitor_cookie && visitor_cookie.length > 0
           @site_visitor = SiteVisitor.find_by_cookie(visitor_cookie)
           @search_history = @site_visitor.site_visitor_history.latest_searches
     end
    
    respond_to do |format|
      format.html { render :template => 'search_history/history' }
    end
  end
 
end
