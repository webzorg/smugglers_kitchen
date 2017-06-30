class SynchronisationController < ApplicationController
  respond_to :json, only: [:synchronise_action]
  include SavonLib

  def index
    # initialize operations table
    get_operations(initialize_savon) if Operation.all.empty?
    @operations = Operation.all

    @mondays_array = initialize_monday_array
  end

  def synchronise_action
    start = Time.zone.now # Start time elapse

    savon_response = nil
    operation_code = synchronisation_params[:operation_code].to_i

    if (0..4).cover?(operation_code)
      savon_response = get_operation(operation_code)
    elsif operation_code == 5
      savon_response = client_debt_data(
        synchronisation_params[:week_date].to_date
      )
    end

    if savon_response.http.code == 200
      update_operation_updated_at(operation_code)

      @json_response = savon_response.body.to_s
      @type = "success"
      @message = t(:synchronisation_is_successful)

      helper_sync(operation_code, savon_response.body) if (0..4).cover?(operation_code)
    else
      @type = "error"
      @message = t(:synchronisation_is_unsuccessful)
    end

    finish = Time.zone.now # Finish time elapse
    @time_elapsed = "#{t(:operation_finished)} #{(finish - start).round(3)} #{t(:in_seconds)}."
  end

  private

    # 0 :get_subdivision
    # 1 :get_trading_agents
    # 2 :get_currencies
    # 3 :get_contractors
    # 4 :get_contracts
    # 5 :get_client_debt_data_view_model

    def initialize_monday_array
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

    def update_operation_updated_at(operation_code)
      Operation.find_by(
        operation_code: operation_code
      ).update_attributes(updated_at: Time.zone.now)
    end

    # Update operations table ONLY if empty
    def get_operations(initialize_savon)
      helper_refresh_operations_table(initialize_savon)
    end

    def get_operation(operation_code)
      helper_get_response_body(initialize_savon, operation_code)
    end

    def client_debt_data(date)
      helper_get_client_debt_data(initialize_savon, 5, date)
    end

    def synchronisation_params
      params.require(:synchronisation).permit(:operation_code, :week_date)
    end
end
