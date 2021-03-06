require 'net/http'
require 'uri'
require 'hpricot'
require 'open-uri'


class SiteCrawler
  def initialize(url, check_url_block = nil)
    @site_uri = URI.parse(url)
    @check_url_block = check_url_block
    #@site_uri.path = "/" if @site_uri.path == ""
    @visited = Hash.new
    @queue = Array.new
    addPath(@site_uri.path)
    puts "Initialized site crawl for #{@site_uri}"
  end

  def addPath(path)
    crawl_this_page = true
    if @check_url_block
      puts "checking: #{full_uri(path)}"
      crawl_this_page = @check_url_block.call(full_uri(path))
      puts "skipping page" unless crawl_this_page
    end
    if crawl_this_page
      @queue.push path
      @visited[path] = false
    end
  end

  def getPage(uri)
    begin
      puts "getting #{uri}"
      response = Net::HTTP.get_response(uri)
    rescue Exception
      puts "Error: #{$!}"
      return ""
    end
    return response.body
  end

  def queueLocalLinks(html)
    doc = Hpricot(html)
    (doc/"a").each do |link|
      href = link.attributes['href']
      begin
        uri = URI.parse(href.strip)
        if !@visited.has_key?(uri.path) and
                (uri.relative? or uri.host == @site_uri.host)
          addPath(uri.path)
        end
      rescue Exception
        puts "Failed to load page at '#{href}'"
      end
    end
  end

  def starts_with_slash(path)
    path[0, 1] == '/'
  end

  def full_uri(path)
    uri = @site_uri.clone
    if starts_with_slash(path)
      uri.path = path
    else
      uri.path = uri.path + '/' + path
    end
    uri
  end

  def crawlSite()
    while (!@queue.empty?)
      uri = @queue.shift
      expanded_uri = full_uri(uri)
      page = getPage(expanded_uri)
      yield expanded_uri.to_s, page
      queueLocalLinks(page)
      @visited[uri] = true
    end
  end
end