require 'net/http'

unless [ENV["HOSTNAME"], ENV["USERNAME"], ENV["PASSWORD"]].all?
  raise "Environment variables HOSTNAME, USERNAME and PASSWORD are required"
end

run Proc.new { |env|
  if env["PATH_INFO"] == "/cc.xml"
    Net::HTTP.start(ENV["HOSTNAME"]) do |http|
      request = Net::HTTP::Get.new("/cc.xml")
      request.basic_auth ENV["USERNAME"], ENV["PASSWORD"]
      [200, {"Content-Type" => "text/xml"}, http.request(request).body]
    end
  else
    [404, {"Content-Type" => "text/plain"}, "Not found"] unless 
  end
}