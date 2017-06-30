class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :currency_id
      t.string :currency_code
      t.string :currency_name

      t.timestamps
    end
  end
end
