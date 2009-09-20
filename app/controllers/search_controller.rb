#include 'UrlWriter'

class SearchController < ApplicationController
  before_filter :check_visitor_history

  layout "public"
  
  def home
     render :template => 'search/search'
  end
  
  def about
    render :text => "TODO - write an about page"
  end
  
  def search
    store_in_visitor_history
    
    started = Time.now
    @page = determine_page 
    
    if params[:facet]
      @results = Document.search(
            params[:q] , 
            params[:facet],
            @page)
    else
      @results = Document.search(
            params[:q] , 
            "",
            @page)
    end
    finished = Time.now
    
    if @results && @results.total > 0
      @paginator = ResultsPaginator.new(@results)
      @paginator.page = determine_page
      
      @category_facet = @results.facets['facet_fields']['category_facet'] 
      @source_facet = @results.facets['facet_fields']['source_facet']     
      @elapsed = finished - started
      render :template => 'search/results'
    else
      render :template => 'search/notfound'
    end
    
  end
  
 
 
 
 
  private
  def determine_page
    page = params[:page] || "1" 
    page.to_i 	
  end
  
  def do_search
  end
  
  def set_user_cookie
  
   mycookie = cookies[:railsmine_history] 
   cookies[:railsmine_history] = {
     :value => 'a yummy cookie',
     :expires => 1.year.from_now
   }

  end
  
  def check_visitor_history
     visitor_cookie = cookies[:railsmine_visitor]
     if visitor_cookie && visitor_cookie.length > 0
       @site_visitor = SiteVisitor.find_by_cookie(visitor_cookie)
       @search_history = @site_visitor.site_visitor_history.latest_5_searches
     else
       visitor_cookie = SiteVisitor.generate_unique_cookie 
       cookies[:railsmine_visitor] = {
          :value => visitor_cookie,
          :expires => 1.year.from_now
        }
        @site_visitor = SiteVisitor.new(:cookie => visitor_cookie)
        @site_visitor.save
        @search_history = Array.new
     end
  
  end
  
  def store_in_visitor_history 
    url = url_for(:controller => 'search',
          :action => 'search',
          :q => params[:q],
          :only_path => true)
          
    @site_visitor.site_visitor_history.new(
    	:displayable_string => params[:q],
    	:url => url
      ).save
      
    @search_history = @site_visitor.site_visitor_history.latest_5_searches

  end
end
