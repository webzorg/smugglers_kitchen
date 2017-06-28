# 0 :get_subdivision
# 1 :get_trading_agents
# 2 :get_currencies
# 3 :get_contractors
# 4 :get_contracts
# 5 :get_client_debt_data_view_model
module SavonLib
  def get_response_body(savon_instance, action_index)
    savon_instance.call(
      savon_instance.operations[action_index],
      message: { "ModeFull" => true }
    ).body
  end

  wsdl_url = "http://#{ENV['host']}/satesto/ws/WebSiteExchange.1cws?wsdl"
  user = ENV["user"]
  pass = ENV["pass"]
  api = Savon.client(
    wsdl: wsdl_url, basic_auth: [user, pass],
    # log: true, log_level: :debug, pretty_print_xml: true
  )
end
