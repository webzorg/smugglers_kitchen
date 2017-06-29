class SynchronisationController < ApplicationController
  respond_to :json, only: [:synchronise_action]
  include SavonLib

  def index
    @operations = Operation.all
  end

  def synchronise_action
    start = Time.zone.now # Start time elapse

    savon_response = nil
    operation_code = synchronisation_params[:operation_code].to_i
    if (0..4).cover?(operation_code)
      savon_response = get_operation(operation_code)
      @json_response = savon_response.body.to_h.to_s
    elsif operation_code == 5
      client_debt_data(Date.new(2017, 5, 29))
    end

    finish = Time.zone.now # Finish time elapse

    @time_elapsed = "#{t(:operation_finished)} #{(finish - start).round(3)} #{t(:in_seconds)}."
    if savon_response.http.code == 200
      Operation.find_by(operation_code: operation_code).update_attributes(updated_at: Time.zone.now)
      @type = "success"
      @message = t(:synchronisation_is_successful)
    else
      @type = "error"
      @message = t(:synchronisation_is_unsuccessful)
    end
  end

  private

    # 0 :get_subdivision
    # 1 :get_trading_agents
    # 2 :get_currencies
    # 3 :get_contractors
    # 4 :get_contracts
    # 5 :get_client_debt_data_view_model

    def get_operation(operation_code)
      helper_get_response_body(initialize_savon, operation_code)
    end

    def client_debt_data(date)
      helper_get_client_debt_data(initialize_savon, 5, date)
    end

    def synchronisation_params
      params.require(:synchronisation).permit(:operation_code)
    end
end
