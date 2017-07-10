class Week < ApplicationRecord
  has_many :client_debt_data

  scope :for_year, lambda { |year|
    where(
      '"monday" >= ? AND monday < ?',
      Date.commercial(year, 1, 1),
      Date.commercial(year + 1, 1, 1)
    )
  }

  scope :sort_ascending, -> { order(monday: :asc) }
  scope :sort_descending, -> { order(monday: :desc) }
end
