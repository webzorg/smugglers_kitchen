class CreateSubdivisions < ActiveRecord::Migration[5.1]
  def change
    create_table :subdivisions do |t|
      t.string :subdivision_id
      t.string :subdivision_code
      t.string :subdivision_name

      t.timestamps
    end
  end
end
