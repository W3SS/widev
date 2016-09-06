class TelegramController < Telegram::Bot::UpdatesController
    include Telegram::Bot::UpdatesController::TypedUpdate

  @@client
  
  def message(mess)
    
    initClient
    rsp = @@client.converse( mess[:chat][:id],mess[:text],{})
    
    logger.info("RESPONSE FROM API")
    logger.info(rsp)

    entities = rsp['entities']
    logger.info("ENTITIES FROM API")
    logger.info(entities)
 
    intent = first_entity_value(entities,"intent")
    env  = first_entity_value(entities,"environment")

     if env != nil
      env_name = env.upcase.strip
      e  = Environment.where(name: env_name).first

      @installations = Installation.where(is_started:true)
                    .where("is_done is null")
                    .where(environment_id: e.id )
                    .order(created_at: :desc)
      
      mess_text = "Below pending installations on "+env+" : \n" 
    
      @installations.each() do |e|
        mess_text =  mess_text +" - " + e.release.to_s + " started on " + e.created_at.strftime("%d-%m-%Y %H:%M:%S")  + "\n"
        
      end
     
     respond_with :message, text: mess_text
    else
      respond_with :message, text: "Please specify the environment... Use /list to get all the installation!"
    end
      
  end
 
  def start(*)
    initClient
    respond_with  :message, text: "Hello #{from['first_name']}! What you want to know ?" 
  end
  
  def list(*)
  
      @installations = Installation.where(is_started:true).where("is_done is null").order(created_at: :desc)

      mess_text = "Ongoing installatins : \n" 
      @installations.each() do |e|
        mess_text =  mess_text +" - " + e.release.to_s + " on "+e.environment.name + " " + e.created_at.strftime("%d-%m-%Y %H:%M:%S")  + "\n"
      end

      respond_with :message, text: mess_text
  end
  
  def env(*)
  
      @envs = Environment.all

      mess_text = "Available environments : \n" 
      @envs.each() do |e|
        mess_text =  mess_text +" - " + e.name.to_s + "\n"
      end

      respond_with :message, text: mess_text
  end

  def help(cmd = nil, *)
     mess_text = "Available commands : \n" 
      
          mess_text =  mess_text +" - /list  : Give the list of ongoing installations \n"
          mess_text =  mess_text + " - /env  : Give list of environments \n"
          
        respond_with  :message, text: mess_text
  end
  
  def initClient
   
   actions = {
      send: -> (request, response) {
        puts("sending... #{response['text']}")
      },
    }

   @@client = Wit.new(access_token: "SSZ7CHFQFQZNQCLZM6MRC6MQCPC4SHCQ", actions: actions)
    
  end
  
  def first_entity_value(entities, entity)
    return nil unless entities.has_key? entity
    val = entities[entity][0]['value']
    return nil if val.nil?
    return val.is_a?(Hash) ? val['value'] : val
  end
  
end