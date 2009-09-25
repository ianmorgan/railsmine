# This helper manages the codeimng and decoding
# of the browse facect into url paramater
#
# A single browse facet is coded
#  facet=facetname:facetvalue
#
# Multiple browse facet are coded
#  facet=facet1name:facet1value#facet2name:facet2value
#

class BrowseFacetsHelper
  attr_reader :browse_facets_hash
  attr_reader :browse_facets_array

  def initialize(browse_facets)
    @browse_facets_array = []
    @browse_facets_array = browse_facets.split('#') unless browse_facets.nil?
    @browse_facets_hash = @browse_facets_array.collect do |f|
       values = f.split(':')
       { values[0] => values[1]}
    end
  end
  
  def append_facet(browse_facet)
     values = browse_facet.split(':')
     @browse_facets_hash << {values[0] => values[1]}
     @browse_facets_array << browse_facet
  end
  
  def encode 
    @browse_facets_array.join('#')
  end
  
  def encode_escaped 
      @browse_facets_array.join('%23')
  end
 

  def contains_facet?(facet)
    @browse_facets_hash.each do |f| 
       if f == facet
         return true
       end
    end
    return false
  end


end