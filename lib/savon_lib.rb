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

  # Save first 5 get actions in local db
  def helper_sync(operation_code, savon_body)
    case operation_code
    when 0
      savon_body[:get_subdivision_response][:return][:subdivision_row].each do |subdivision|
        Subdivision.find_or_create_by(subdivision)
      end
    when 1
      savon_body[:get_trading_agents_response][:return][:trading_agents_row].each do |trading_agent|
        TradingAgent.find_or_create_by(trading_agent)
      end
    when 2
      savon_body[:get_currencies_response][:return][:currencies_row].each do |currency|
        Currency.find_or_create_by(currency)
      end
    when 3
      savon_body[:get_contractors_response][:return][:contractor_row].each do |contractor|
        Contractor.find_or_create_by(contractor)
      end
    when 4
      savon_body[:get_contracts_response][:return][:contracts_row].each do |contract|
        Contract.find_or_create_by(contract)
      end
    end
  end

  # create list of Mondays until present in 2017
  def helper_initialize_monday_array
    date_index = Date.commercial(2017, 1, 1)
    index = 1
    arr = []

    until date_index >= Time.zone.now.beginning_of_week
      date_index = Date.commercial(2017, index, 1)
      arr << ["#{index.to_s.rjust(2, '0')} | #{date_index.strftime('%B %d, %Y')}", date_index]
      index += 1
    end

    arr
  end
end
