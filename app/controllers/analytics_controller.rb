class AnalyticsController < ApplicationController
  before_action :set_preseller, only: [:select_preseller_action]
  before_action :set_contractor, only: [:select_contractor_action]
  respond_to :json, only: [:select_preseller_action, :select_contractor_action]

  def index
    @presellers = TradingAgent.preseller
  end

  def select_preseller_action
    return if @preseller.nil?
    @preseller_contractors = ""

    @preseller.contracts.each do |contract|
      next if contract.contractor.nil?
      contractor_id = contract.contractor.customer_id
      contractor_name = contract.contractor.customer_name
      option = "<option value='#{contractor_id}'>#{contractor_name}</option>"

      @preseller_contractors += option
    end
  end

  def select_contractor_action
    return if @contractor.nil?
    @contract_name = @contractor.contracts.first.contract_name
    @contract_type = @contractor.contracts.first.contract_type
    @contract_currency = @contractor.contracts.first.currency.currency_name
    @contract_preseller = @contractor.contracts.first.trading_agent.trading_agent_name
    @contract_subdivision = @contractor.contracts.first.subdivision.subdivision_name

    @contractor_name = @contractor.customer_name
    @contractor_code = @contractor.customer_code
    @contractor_state_id = @contractor.customer_tin
    @contractor_physical_address = @contractor.customer_actual_address
    @contractor_legal_address = @contractor.customer_legal_address
    @contractor_type = @contractor.customer_type
  end

  private

    def set_preseller
      @preseller = TradingAgent.where(trading_agent_id: analytics_params[:preseller_id]).first
    end

    def set_contractor
      @contractor = Contractor.where(customer_id: analytics_params[:contractor_id]).first
    end

    def analytics_params
      params.require(:analytics).permit(:preseller_id, :contractor_id)
    end
end
