class CreateOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :operations do |t|
      t.string :operation_code
      t.string :operation_name

      t.timestamps
    end
  end
end
