class ClientDebtDatum < ApplicationRecord
  belongs_to :week
  belongs_to :contractor, foreign_key: :contract_id
end
