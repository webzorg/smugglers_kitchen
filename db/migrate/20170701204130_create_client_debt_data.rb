class CreateClientDebtData < ActiveRecord::Migration[5.1]
  def change
    create_table :client_debt_data do |t|
      t.string :contract_id
      t.string :amount_beginning
      t.string :sales
      t.string :sales_returns
      t.string :debt_adjustment
      t.string :payment
      t.string :amount_returns
      t.string :amount_the_end

      t.timestamps
    end
  end
end
