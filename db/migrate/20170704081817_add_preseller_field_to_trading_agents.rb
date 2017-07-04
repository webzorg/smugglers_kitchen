class AddPresellerFieldToTradingAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :trading_agents, :preseller, :boolean
  end
end
