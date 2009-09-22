xml.instruct!
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @documents.each do |doc|
    xml.url do
      xml.loc url_for(:host => 'www.railsmine.com', :controller => 'search', :action => 'document', :id => doc.id)
      xml.lastmod doc.updated_at.xmlschema
    end
  end
end