class Api::JenkinsController < ApplicationController

  def runjob

    @item = ItemPerInstallation.find(params[:item_id]);

    job = @item.rel_template_item.command
    rel = @item.installation.release
    env = @item.installation.environment

    uri = URI.parse( URI::encode(Rails.configuration.x.jenkins.url+"/job/"+job+"/buildWithParameters"));
    logger.info("Contacting Jenkins on " + uri.path)
    http = Net::HTTP.new(uri.host, uri.port)

    #req = Net::HTTP::Post.new(uri)
    req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'Application/json'})

    req.basic_auth Rails.configuration.x.jenkins.user, Rails.configuration.x.jenkins.password
    req.set_form_data({"REL" => rel, "ENVIRONMENT" => env.name})
    #req.body= {'parameter': [{"REL": rel }, {"name":"ENVIRONMENT", "value": env.name }]}.to_json


    logger.info (req.body)

    res = http.request(req)

    logger.info (res.body)

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
  req.basic_auth Rails.configuration.x.jenkins.user, Rails.configuration.x.jenkins.password
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
    uri = URI.parse( URI::encode(Rails.configuration.x.jenkins.url+"/job/"+job+"/buildWithParameters"));

    uri = URI.parse( @item.job_id + "api/json");

    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Get.new(uri)
    req.basic_auth Rails.configuration.x.jenkins.user, Rails.configuration.x.jenkins.password

    res = http.request(req)

    render json: res.body
  end


  def joblog
    @item = ItemPerInstallation.find(params[:item_id]);


    uri = URI.parse( @item.job_id + "consoleText");
    logger.info("retrieving log for " + @item.job_id)
    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Get.new(uri)
    res = http.request(req)

    render json: res.body
  end

  def getbuildurl
    @item = ItemPerInstallation.find(params[:item_id])
    job = @item.rel_template_item.command
    Rails.configuration.x.jenkins.url+"/job/"+job

    render json: Rails.configuration.x.jenkins.url+"/job/" +job
  end
end
