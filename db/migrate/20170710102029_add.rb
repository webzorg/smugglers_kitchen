class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :contractors, :debt, :float, default: 0, null: false
  end
end
