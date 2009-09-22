class SitemapController < ApplicationController

  def sitemap
   @documents = Document.find_for_sitemap
   headers["Last-Modified" ] = @documents.last.updated_at.httpdate if @documents.size > 0
   render :layout => false
  end

end
