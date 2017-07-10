class ClientDebtDatumChangeFieldsFromStringToFloats < ActiveRecord::Migration[5.1]
  def change
    change_column :client_debt_data, :amount_beginning, "float USING amount_beginning::double precision", default: 0, null: false
    change_column :client_debt_data, :sales,            "float USING sales::double precision",            default: 0, null: false
    change_column :client_debt_data, :sales_returns,    "float USING sales_returns::double precision",    default: 0, null: false
    change_column :client_debt_data, :debt_adjustment,  "float USING debt_adjustment::double precision",  default: 0, null: false
    change_column :client_debt_data, :payment,          "float USING payment::double precision",          default: 0, null: false
    change_column :client_debt_data, :amount_returns,   "float USING amount_returns::double precision",   default: 0, null: false
    change_column :client_debt_data, :amount_the_end,   "float USING amount_the_end::double precision",   default: 0, null: false
  end
end
