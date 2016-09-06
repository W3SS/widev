class Api::JenkinsController < ApplicationController

  def runjob

    @item = ItemPerInstallation.find(params[:item_id]);

    job = @item.rel_template_item.command
    rel = @item.installation.release
    env = @item.installation.environment

    uri = URI.parse( URI::encode("http://localhost:8080/job/"+job+"/build"));

    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
    req.basic_auth 'andbet39', '26111979'
    req.body= {"parameter": [{"name":"REL_TYPE", "value":"EVOLUTIVO"},{"name":"RELEASE", "value": rel }, {"name":"ENVIRONMENT", "value": env }]}.to_json

    res = http.request(req)

    uri = URI.parse( res['Location'] + "api/json");
    req = Net::HTTP::Get.new(uri, initheader = {'Content-Type' =>'application/json'})
    @item.job_id =nil

    while @item.job_id == nil
      sleep 1
      @item.job_id = getjobid(res['Location'])
      logger.info(@item.job_id)
    end

    @item.save!

    respond_to do |format|
      format.json { render :'api/installation/show', status: :ok, location: @item }
    end
  end

  def getjobid (queueurl)
  logger.info("GETjobid " +  queueurl)
    uri = URI.parse( queueurl + "api/json");
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth 'andbet39', '26111979'
    res = http.request(req)

    queue  = JSON.parse(res.body)
    executable  = queue['executable']

  logger.info(executable)

  if(executable != nil )
       queue['executable']['url']

    else
      nil
    end
  end


  def jobinfo
    @item = ItemPerInstallation.find(params[:item_id]);

    uri = URI.parse( @item.job_id + "api/json");

    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Get.new(uri)
    req.basic_auth 'andbet39', '26111979'

    res = http.request(req)

    render json: res.body
  end


  def joblog
    @item = ItemPerInstallation.find(params[:item_id]);

    uri = URI.parse( @item.job_id + "consoleText");

    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Get.new(uri)
    req.basic_auth 'andbet39', '26111979'

    res = http.request(req)

    render json: res.body
  end
end
