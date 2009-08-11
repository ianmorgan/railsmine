class ResultsPaginator
  attr_accessor :page
  RESULTS_PER_PAGE = 20
  
  def initialize(results)
    @results = results
  end
  
  def allpages
    (1..((@results.total-1)/RESULTS_PER_PAGE+1)).collect
  end
  
  def current_start_record
    (@page -1) * RESULTS_PER_PAGE + 1
  end
  
  def current_end_record
    [total_records, (@page) * RESULTS_PER_PAGE].min
  end
  
  def total_records
    @results.total
  end
 
  
end
