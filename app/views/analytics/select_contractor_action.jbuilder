json.contract_name               @contractor.contracts.first.contract_name
json.contract_type               @contractor.contracts.first.contract_type
json.contract_currency           @contractor.contracts.first.currency.currency_name
json.contract_preseller          @contractor.contracts.first.trading_agent.trading_agent_name
json.contract_subdivision        @contractor.contracts.first.subdivision.subdivision_name

json.contractor_name             @contractor.customer_name
json.contractor_code             @contractor.customer_code
json.contractor_state_id         @contractor.customer_tin
json.contractor_physical_address @contractor.customer_actual_address
json.contractor_legal_address    @contractor.customer_legal_address
json.contractor_type             @contractor.customer_type

json.client_debt_data @client_debt_data
