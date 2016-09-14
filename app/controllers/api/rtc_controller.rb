class Api::RtcController < ApplicationController
  def updateWorkItemByInstallation

    wi = params[:wi]
    installation = Installation.find(params[:installation_id])

    rtcinfo = RtcInfo.find_by_users_id(current_user.id)

    logger.info("ADT : " << wi)


    #uri = URI.parse(Rails.configuration.x.rtc.url"+/ccm/oslc/workitems/"+wi+".json")
    uri = URI.parse("https://adtclmemea03301.accenture.com/ccm/oslc/workitems/"+wi+".json")

    logger.info("URI: " << uri.host)
    logger.info("RTC User: " << rtcinfo.username)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new uri

    req.basic_auth rtcinfo.username, rtcinfo.password

    res = http.start { |http| http.request req }
    @wi = JSON.parse(res.body)


    date = DateTime.now
    now  = date.strftime('%a %b %d %H:%M:%S')

    @wi['rtc_cm:com.acn.adt3.workitem.attribute.resolution'] = @wi['rtc_cm:com.acn.adt3.workitem.attribute.resolution'] + "<br/> Installed on "+now+" with rel: "+installation.release+ " on "+installation.environment.name+" <br/>"
    @wi['rtc_cm:state'] = {
        "rdf:resource":"https://adtclmemea03301.accenture.com/ccm/oslc/workflows/_7gDwIOpqEeW3FYFwwhfPkA/states/com.acn.adt3.workflow.defect/com.acn.adt3.workflow.defect.state.s4"
    }
    @wi['rtc_cm:resolution']={
        "rdf:resource":"https://adtclmemea03301.accenture.com/ccm/oslc/workflows/_7gDwIOpqEeW3FYFwwhfPkA/resolutions/com.acn.adt3.workflow.defect/com.acn.adt3.workflow.defect.resolution.r1"
    }


    uri = URI.parse("https://adtclmemea03301.accenture.com/ccm/oslc/workitems/"+wi+"?_action=com.acn.adt3.workflow.defect.action.a5")

    req = Net::HTTP::Put.new(uri, initheader = {'Content-Type' =>'application/json'})
    req.body= @wi.to_json
    req.basic_auth rtcinfo.username, rtcinfo.password

    res = http.start { |http| http.request req }
    logger.info(res.body)

    render json: "Success"

  end
end
