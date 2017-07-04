# Helper module for synchronisation c
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

  def helper_refresh_operations_table(savon)
    savon.operations.each_with_index do |operation, index|
      Operation.find_or_create_by(
        operation_code: index,
        operation_name: operation.to_s.sub("get_", "").humanize
      )
    end
  end

  def helper_get_response_body(sav, action_index)
    sav.call(sav.operations[action_index], message: { "ModeFull" => true })
  end

  def get_client_debt_data(sav, action_index, date)
    sav.call(sav.operations[action_index], message: { "CreateDate" => date })
  end

  # Save first 5 get actions in local db
  # 0 :get_subdivision
  # 1 :get_trading_agents
  # 2 :get_currencies
  # 3 :get_contractors
  # 4 :get_contracts
  # 5 :get_client_debt_data_view_model

  def helper_sync(operation_code, savon_body = nil, monday_date = nil)
    case operation_code
    when 0
      savon_body[:get_subdivision_response][:return][:subdivision_row].each do |subdivision|
        Subdivision.find_or_create_by(
          subdivision_id: subdivision[:subdivision_id]
        ).update_attributes(subdivision)
      end
    when 1
      savon_body[:get_trading_agents_response][:return][:trading_agents_row].each do |trading_agent|
        TradingAgent.find_or_create_by(
          trading_agent_id: trading_agent[:trading_agent_id]
        ).update_attributes(trading_agent)
      end
    when 2
      savon_body[:get_currencies_response][:return][:currencies_row].each do |currency|
        Currency.find_or_create_by(
          currency_id: currency[:currency_id]
        ).update_attributes(currency)
      end
    when 3
      savon_body[:get_contractors_response][:return][:contractor_row].each do |contractor|
        Contractor.find_or_create_by(
          customer_id: contractor[:customer_id] # Field names don't match model name.
        ).update_attributes(contractor)
      end
    when 4
      savon_body[:get_contracts_response][:return][:contracts_row].each do |contract|
        Contract.find_or_create_by(
          contract_id: contract[:contract_id]
        ).update_attributes(contract)
      end
    when 5
      successfull_syncs = failed_syncs = 0
      savon = initialize_savon

      until monday_date >= Time.zone.now.beginning_of_week
        week = Week.find_or_create_by(
          monday: Date.commercial(monday_date.year, monday_date.cweek, 1)
        )

        savon_response = get_client_debt_data(savon, operation_code, monday_date)

        if !savon_response.nil? && savon_response.http.code == 200
          monday_date = monday_date.next_week
          savon_body = savon_response.body

          savon_body[:get_client_debt_data_view_model_response][:return][:client_debt_data_view_model_row].each do |client_debt_data|
            client_debt_data[:week_id] = week.id
            ClientDebtDatum.find_or_create_by(
              contract_id: client_debt_data[:contract_id],
              week_id: client_debt_data[:week_id]
            ).update_attributes(client_debt_data)
          end
          successfull_syncs += 1
        else
          failed_syncs += 1
        end
      end

      generate_flash_message(successfull_syncs, failed_syncs)
    end
  end

  def generate_flash_message(successfull_syncs, failed_syncs)
    if failed_syncs.zero?
      type = "success"
      message = "#{I18n.t(:successfully_synced)} #{successfull_syncs} #{I18n.t(:weeks_of_data)}"
    elsif successfull_syncs.zero?
      type = "error"
      message = I18n.t(:client_debt_data_sync_failed)
    else
      type = "warning"
      message = "
        #{I18n.t(:successfully_synced)} #{successfull_syncs} #{I18n.t(:weeks_of_data)} \n
        #{I18n.t(:and_failed)} #{failed_syncs} #{I18n.t(:weeks_of_data)}"
    end
    [type, message]
  end
end
