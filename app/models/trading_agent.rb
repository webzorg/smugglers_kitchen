class TradingAgent < ApplicationRecord
  self.primary_key = "trading_agent_id"
  has_many :contracts
end
