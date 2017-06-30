# 0 :get_subdivision
# 1 :get_trading_agents
# 2 :get_currencies
# 3 :get_contractors
# 4 :get_contracts
# 5 :get_client_debt_data_view_model

module SavonLib
  def initialize_savon
    wsdl_url = "http://#{ENV['host']}/satesto/ws/WebSiteExchange.1cws?wsdl"
    user = ENV["user"]
    pass = ENV["pass"]

    Savon.client(
      wsdl: wsdl_url, basic_auth: [user, pass],
      # log: true, log_level: :debug, pretty_print_xml: true
    )
  end

  def helper_get_response_body(sav, action_index)
    sav.call(sav.operations[action_index], message: { "ModeFull" => true })
  end

  def helper_get_client_debt_data(sav, action_index, date)
    sav.call(sav.operations[action_index], message: { "CreateDate" => date })
  end

  def helper_refresh_operations_table(savon)
    savon.operations.each_with_index do |operation, index|
      Operation.find_or_create_by(
        operation_code: index,
        operation_name: operation.to_s.sub("get_", "").humanize
      )
    end
  end
end
