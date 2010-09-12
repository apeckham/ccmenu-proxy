require 'net/https'

class ProxyApp
  def call(env)
    if env["PATH_INFO"] == "/cc.xml"
      begin
        http = Net::HTTP.new("staging.urbandictionary.com", 443)
        http.use_ssl = true
        
        http.start do |http|
          request = Net::HTTP::Get.new("/build/cc.xml")
          request.basic_auth "view", "neth7em2"
          response = http.request(request)
        
          if response.is_a? Net::HTTPOK
            [200, {"Content-Type" => "text/xml"}, response.body]
          else
            [200, {"Content-Type" => "text/xml"}, "<Projects></Projects>"]
          end
        end
      rescue Errno::ECONNREFUSED
        [200, {"Content-Type" => "text/xml"}, "<Projects></Projects>"]
      end
    else
      [404, {"Content-Type" => "text/plain"}, "Not found"] 
    end
  end
end