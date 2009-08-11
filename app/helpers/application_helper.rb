# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  
  def shorten (string, count = 500)
  	if string.length >= count 
  		shortened = string[0, count]
  		splitted = shortened.split(/\s/)
  		words = splitted.length
  		splitted[0, words-1].join(" ") + ' ...'
  	else 
  		string
  	end
  end

  
end
