require 'net/http'

class ViewerController < ApplicationController 

 def highlighted 
   puts "in highlighted "
   puts ">>" +  path_without_terms + "<<" 
   puts ">>" +  path_without_terms + "<<" 
 
 puts path_without_terms.class
  
   puts 'making http call'
   page = Net::HTTP.get 'localhost', '/' + path_without_terms, 3000
   #puts page
   #page = "abc"
   puts 'http call completed'
   render :text => page
 end
 
private
  def path_without_terms
     #params[:specs].join('/').split("\&")[0]
     path = params[:specs].clone
     path.pop
     path.join('/')     
  end
  
  def terms
     params[:specs].last
  end
  
end