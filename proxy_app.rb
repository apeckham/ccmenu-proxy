require 'net/http'

class ProxyApp
  def call(env)
    if env["PATH_INFO"] == "/cc.xml"
      begin
        Net::HTTP.start(ENV["HOSTNAME"]) do |http|
          request = Net::HTTP::Get.new("/cc.xml")
          request.basic_auth ENV["USERNAME"], ENV["PASSWORD"]
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