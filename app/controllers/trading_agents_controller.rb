class TradingAgentsController < ApplicationController
  before_action :set_trading_agent, only: [:edit, :update]

  def index
    @trading_agents = TradingAgent.all.order(preseller: :asc)
  end

  def edit
  end

  def update
    if @trading_agent.update(trading_agent_params)
      redirect_to trading_agents_path, notice: "Trading agent was successfully updated."
    else
      render :edit
    end
  end

  private

    def set_trading_agent
      @trading_agent = TradingAgent.find(params[:id])
    end

    def trading_agent_params
      params.require(:trading_agent).permit(:trading_agent_id, :preseller)
    end
end
