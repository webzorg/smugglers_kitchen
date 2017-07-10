class AnalyticsController < ApplicationController
  before_action :set_preseller, only: [:select_preseller_action]
  before_action :set_contractor, only: [:select_contractor_action]
  respond_to :json, only: [:select_preseller_action, :select_contractor_action]

  def index
    @presellers = TradingAgent.preseller
  end

  def select_preseller_action
    return if @preseller.nil?
    @preseller_contractors = "<option value='' disabled selected>#{I18n.t(:select_contractor)}</option>"

    @preseller.contractors.by_debt_descending.each do |contractor|
      next if contractor.nil?
      @preseller_contractors +=
        "<option value='#{contractor.customer_id}'>#{contractor.customer_name} - #{(contractor.debt / 1000).round(1)}k</option>"
    end
  end

  def select_contractor_action
    return if @contractor.nil?

    @client_debt_data = ""
    weeks = Week.for_year(analytics_params[:year].to_i).sort_descending
    weeks.each.with_index(0).map do |week, index|
      # option 2
      # client_debt_datum = week.client_debt_data.where(contract_id: @contractor.customer_id)
      client_debt_datum = @contractor.client_debt_data.where(week_id: week.id).first
      next if client_debt_datum.nil?
      week_number = (weeks.length - index).to_s.rjust(2, "0")
      date = week.monday.strftime("%d / %B / %Y")

      @client_debt_data +=
        render_to_string partial: "analytics/week", locals: {
          week_number: week_number,
          date: date,
          client_debt_datum: client_debt_datum
        }
    end
  end

  private

    def set_preseller
      @preseller = TradingAgent.where(trading_agent_id: analytics_params[:preseller_id]).first
    end

    def set_contractor
      @contractor = Contractor.where(customer_id: analytics_params[:contractor_id]).first
    end

    def analytics_params
      params.require(:analytics).permit(:preseller_id, :contractor_id, :year)
    end
end
