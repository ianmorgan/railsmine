module DocumentsHelper

  def displayable_abstract(doc)
    if doc.abstract && doc.abstract.length > 0   
      shorten(strip_tags(doc.abstract),300)
    else
      'Sorry - no preview'
    end
  end
  
  #todo - not polymorphic!
  def displayable_facet_name(facet_name, facet_value)
    if facet_name == 'category' 
       Document.category_full_name(facet_value)
    else
       Document.source_full_name(facet_value)      
    end
  end
end
