class CreateTradingAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :trading_agents do |t|
      t.string :trading_agent_id
      t.string :trading_agent_code
      t.string :trading_agent_name

      t.timestamps
    end
  end
end
