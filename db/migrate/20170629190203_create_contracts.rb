class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.string :contract_id
      t.string :customer_id
      t.string :contract_code
      t.string :contract_name
      t.string :contract_type
      t.string :currency_id
      t.string :trading_agent_id
      t.string :subdivision_id

      t.timestamps
    end
  end
end
