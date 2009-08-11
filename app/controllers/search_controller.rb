class SearchController < ApplicationController
  
  layout "public"
  
  def home
     render :template => 'search/search'
  end
  
  def about
    render :text => "TODO - write an about page"
  end
  
  def search
    started = Time.now
    @page = determine_page 
    
    if params[:facet]
      @results = Document.find_by_solr(
           params[:q], 
           :facets => {:fields => [:category, :source] ,
           :browse => ["#{params[:facet]}:#{params[:browse]}"] },
           :offset => (@page-1)*20, 
           :limit => 20)
    else
      @results = Document.find_by_solr(
           params[:q], 
           :facets => {:fields => [:category, :source] },
           :offset => (@page-1)*20, 
           :limit => 20)
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
end
