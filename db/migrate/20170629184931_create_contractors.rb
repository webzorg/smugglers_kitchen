class CreateContractors < ActiveRecord::Migration[5.1]
  def change
    create_table :contractors do |t|
      t.string :customer_id
      t.string :customer_code
      t.string :customer_tin
      t.string :customer_actual_address
      t.string :customer_legal_address
      t.string :customer_type
      t.string :customer_name

      t.timestamps
    end
  end
end
