class Contract < ApplicationRecord
  self.primary_key = "contract_id"
  belongs_to :subdivision
  belongs_to :trading_agent
  belongs_to :currency
  belongs_to :contractor, foreign_key: :customer_id
end
