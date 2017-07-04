class AddWeekReferenceToClientDebtData < ActiveRecord::Migration[5.1]
  def change
    add_reference :client_debt_data, :week, index: true
  end
end
