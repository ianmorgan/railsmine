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
  attr_reader :browse_facets

  def initialize(browse_facets)
    @browse_facets = []
    @browse_facets = browse_facets.split('#') unless browse_facets.nil?
    @browse_facets = @browse_facets.collect do |f|
       values = f.split(':')
       { values[0] => values[1]}
    end
  end

  def contains_facet?(facet)
    @browse_facets.each do |f| 
       if f == facet
         return true
       end
    end
    return false
  end


end