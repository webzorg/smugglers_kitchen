class ClientDebtDatum < ApplicationRecord
  belongs_to :week
  belongs_to :contractor, foreign_key: :contract_id
  scope :by_weeks_ascending, -> { joins(:week).order("weeks.monday ASC") }
end
