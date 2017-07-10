class TradingAgent < ApplicationRecord
  self.primary_key = "trading_agent_id"
  has_many :contracts
  has_many :contractors, through: :contracts
  scope :preseller, -> { where(preseller: true) }
end
