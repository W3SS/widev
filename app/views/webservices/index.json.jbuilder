json.array!(@webservices) do |webservice|
  json.extract! webservice, :id, :name, :int_endpoint, :bs, :bs_method, :applet, :applet_method, :description
  json.url webservice_url(webservice, format: :json)
end
