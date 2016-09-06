require "uri"
require "net/http"
require 'openssl'

uri = URI.parse("https://adtclmemea03301.accenture.com/ccm/authenticated/identity")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true if uri.scheme == 'https'
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

req = Net::HTTP::Get.new uri
req.basic_auth 'andrea.terzani', 'Agosto2016'

res = http.start { |http| http.request req }
puts res.body