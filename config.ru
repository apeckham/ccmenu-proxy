require File.dirname(__FILE__) + '/proxy_app'

unless [ENV["HOSTNAME"], ENV["USERNAME"], ENV["PASSWORD"]].all?
  raise "Environment variables HOSTNAME, USERNAME and PASSWORD are required"
end

run ProxyApp.new