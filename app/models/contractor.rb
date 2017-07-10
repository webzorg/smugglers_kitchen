class Contractor < ApplicationRecord
  self.primary_key = "customer_id"
  has_many :contracts, foreign_key: :customer_id
  has_many :client_debt_data, foreign_key: :contract_id

  scope :by_debt_descending, -> { order(debt: :desc) }
end
