class ResultsPaginator
  attr_accessor :page

  def initialize(results)
    @results = results
  end
  
  def allpages
    (1..((@results.total-1)/RailsMineConfig.results_per_page+1)).collect
  end
  
  def current_start_record
    (@page -1) * RailsMineConfig.results_per_page+ 1
  end
  
  def current_end_record
    [total_records, (@page) * RailsMineConfig.results_per_page].min
  end
  
  def total_records
    @results.total
  end
 
  
end
