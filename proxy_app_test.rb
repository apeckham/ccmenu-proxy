require 'test/unit'
require File.dirname(__FILE__) + '/proxy_app'

class MyTest < Test::Unit::TestCase
  def test_truth
    status, headers, body = ProxyApp.new.call({"PATH_INFO" => "/cc.xml"})
    assert_equal 200, status
    assert_match %r[<Projects>.+</Projects>], body
  end
end