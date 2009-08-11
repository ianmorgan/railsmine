class WordHighlighter
  def initialize(app)
    @app = app
    puts "initialized WordHighlighter"
  end
  
  def call(env)
        status, headers, response = @app.call env
        if response.respond_to? "body" 
           req = Rack::Request.new(env)
           term = req.GET["term"]
           puts term 
           
           puts req.GET.class
           req.GET.each {|k,v| puts k + v }
           if term  && term.length > 0 
              modified_response = response.body.gsub(term, '<span style="background: #EEEEEE">' + term + '</span>')
              headers["Content-Length"] = modified_response.length.to_s
              [status, headers, modified_response]
           else
              [status, headers, response]
           end
        else
           [status, headers, response]
        end
   end
end
