#include 'UrlWriter'

class SearchController < ApplicationController
  before_filter :check_visitor_history

  layout "public"
  
  def home
     render :template => 'search/search'
  end
  
  def about
    render :template => 'search/about'
  end

  def hints
    render :template => 'search/hints'
  end

  def unauthorised
    render :text => "Not authorised"
  end

  def searchmethods
    started = Time.now
    @page = determine_page
    @facets = BrowseFacetsHelper.new(params[:facet]).browse_facets_array
    @methods = MethodOrClass.find_by_solr("method_name:#{params[:q]} + is_method:true",
                                          :limit => RailsMineConfig.results_per_page,
                                          :offset => (@page-1)*RailsMineConfig.results_per_page )
    # hack - keep view partials happy
    @results = @methods 
    finished = Time.now

    if @methods and @methods.total > 0
      @paginator = ResultsPaginator.new(@methods)
      @paginator.page = determine_page

      @elapsed = finished - started
      render :template => 'search/methodsresults'
    else
      render :template => 'search/notfound'
    end
    
  end
  
  def searchclasses
      started = Time.now
      @page = determine_page
      @facets = BrowseFacetsHelper.new(params[:facet]).browse_facets_array
      @classes = MethodOrClass.find_by_solr("class_name:#{params[:q]} + is_class:true",
                                            :limit => RailsMineConfig.results_per_page,
                                            :offset => (@page-1)*RailsMineConfig.results_per_page )
      finished = Time.now
  
      if @classes and @classes.total > 0
        @paginator = ResultsPaginator.new(@classes)
        @paginator.page = determine_page
  
        @elapsed = finished - started
        render :template => 'search/classesresults'
      else
         render :template => 'search/notfound'
      end
      
    end

 
  def search
    store_in_visitor_history
    
    started = Time.now
    @page = determine_page 
    @facets = BrowseFacetsHelper.new(params[:facet]).browse_facets_array
    
    if params[:facet]
      @results = Document.search(
            params[:q] , 
            @facets,
            @page)
    else
      @results = Document.search(
            params[:q] , 
            "",
            @page)
    end
    
    @methods = MethodOrClass.find_by_solr("method_name:#{params[:q]} + is_method:true", :limit => 3)
    @classes = MethodOrClass.find_by_solr("class_name:#{params[:q]} + is_class:true", :limit =>3)

    finished = Time.now
    
    if @results && @results.total > 0
      @paginator = ResultsPaginator.new(@results)
      @paginator.page = determine_page

       @facets_param = ""
       unless params[:facet].nil?
          helper = BrowseFacetsHelper.new(params[:facet])
          @facets_param = helper.encode_escaped
       end

      @elapsed = finished - started
      render :template => 'search/results'
    else
      render :template => 'search/notfound'
    end
    
  end

  # todo - being lazy this really isnt the place for this action !!
  def document
    begin
      @document = Document.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      #dont care
    end
    render :template => 'search/document'
  end
  
 
 
 
 
  private
  def determine_page
    page = params[:page] || "1" 
    page.to_i 	
  end
  
  def do_search
  end
  
#  def set_user_cookie
#  
#   mycookie = cookies[:railsmine_history] 
#   cookies[:railsmine_history] = {
#     :value => 'a yummy cookie',
#     :expires => 1.year.from_now
#   }
#
#  end
  
  def check_visitor_history
     @search_history = Array.new
     visitor_cookie = cookies[:railsmine_visitor]
     if visitor_cookie 
       @site_visitor = SiteVisitor.find_by_cookie(visitor_cookie)
       if @site_visitor
          @search_history = @site_visitor.site_visitor_history.latest_5_searches
       else 
          create_new_cookie
       end
     else
       create_new_cookie
     end
  
  end
  
  def store_in_visitor_history
    if params[:facet].nil? && determine_page == 1
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
  
  def create_new_cookie
     visitor_cookie = SiteVisitor.generate_unique_cookie 
     cookies[:railsmine_visitor] = {
            :value => visitor_cookie,
            :expires => 1.year.from_now
     }
     @site_visitor = SiteVisitor.new(:cookie => visitor_cookie)
     @site_visitor.save

  end

end
