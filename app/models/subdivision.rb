class Subdivision < ApplicationRecord
  self.primary_key = "subdivision_id"
  has_many :contracts
end
