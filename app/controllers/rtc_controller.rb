class RtcController < ApplicationController


  def index
    uri = URI.parse("https://adtclmemea03301.accenture.com/ccm/oslc/workitems/38140.json")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new uri
    req.basic_auth 'andrea.terzani', 'Agosto2016'

    res = http.start { |http| http.request req }
    @wi = JSON.parse(res.body)


    logger.info(@wi['dc:description'])


    @wi['dc:description'] = @wi['dc:description'] + "<br/> Just updated by Ruby <br/>"

    req = Net::HTTP::Put.new(uri, initheader = {'Content-Type' =>'application/json'})

    req.body= @wi.to_json


    req.basic_auth 'andrea.terzani', 'Agosto2016'

    res = http.start { |http| http.request req }
    logger.info(res.body)

  end

  def get

    rm  = ReleaseManager.new
    rm.getWorkItemForRelease('REL4.12.164')

  end
end
