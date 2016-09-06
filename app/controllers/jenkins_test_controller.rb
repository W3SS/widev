class JenkinsTestController < ApplicationController
  def joblist
    @client = JenkinsApi::Client.new(:server_ip => '127.0.0.1',
                                     :username => 'andbet39', :password => '26111979')
    puts @client.job.list_all

  end

  def jobstart
    @client = JenkinsApi::Client.new(:server_ip => '127.0.0.1',
                                     :username => 'andbet39', :password => '26111979')
    code =  @client.job.build("Deploy SRF",{"REL_TYPE" => 'Upgrade_8.1' ,'ENVIRONMENT' =>'CRMDA'})
    puts code

    raise "Could not build the job specified" unless code == '201'


  end
end
