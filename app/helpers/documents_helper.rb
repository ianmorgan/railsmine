module DocumentsHelper

  def displayable_abstract(doc)
    if doc.abstract && doc.abstract.length > 0   
      shorten(strip_tags(doc.abstract),300)
    else
      'Sorry - no preview'
    end
  end
end
