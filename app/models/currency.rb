class Currency < ApplicationRecord
  self.primary_key = "currency_id"
  has_many :contracts
end
