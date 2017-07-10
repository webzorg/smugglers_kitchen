class SynchronisationController < ApplicationController
  respond_to :json, only: [:synchronise_action]
  include SavonLib
  include ActionView::Helpers::DateHelper

  def index
    # initialize operations table
    get_operations(initialize_savon) if Operation.all.empty?
    @operations = Operation.all
    @mondays_array = initialize_mondays_array
  end

  def synchronise_action
    start = Time.zone.now # Start time elapse

    savon_response = nil
    operation_code = synchronisation_params[:operation_code].to_i

    savon_response = get_operation(operation_code) if (0..4).cover?(operation_code)

    if !savon_response.nil? && savon_response.http.code == 200
      update_operation_updated_at(operation_code)

      @type = "success"
      @message = t(:synchronisation_is_successful)

      if (0..4).cover?(operation_code)
        helper_sync(operation_code, savon_response.body)
      end
    elsif operation_code == 5
      resp = helper_sync(operation_code, nil, synchronisation_params[:week_date].to_date)
      @type = resp[0]
      update_operation_updated_at(operation_code) if @type == "success"
      @message = resp[1]
    else
      @type = "error"
      @message = t(:sync_failed)
    end

    @time_elapsed = "#{t(:operation_finished_in)} #{time_ago_in_words(start, include_seconds: true)}."
  end

  private

    # 0 :get_subdivision
    # 1 :get_trading_agents
    # 2 :get_currencies
    # 3 :get_contractors
    # 4 :get_contracts
    # 5 :get_client_debt_data_view_model

    def initialize_mondays_array
      date_index = Date.commercial(YEAR_SETTER, 1, 1)
      arr = []
      until date_index >= Time.zone.now.beginning_of_week
        arr << ["#{date_index.cweek.to_s.rjust(2, '0')} | #{date_index.strftime('%B %d, %Y')}", date_index]
        date_index = date_index.next_week
      end

      arr.reverse
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

    def synchronisation_params
      params.require(:synchronisation).permit(:operation_code, :week_date)
    end
end
