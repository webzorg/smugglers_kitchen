json.array!(@contractors_by_debt) do |contractor|
  json.name contractor.customer_name[0..20]
  json.debt contractor.debt
end
