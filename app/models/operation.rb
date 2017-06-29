class Operation < ApplicationRecord
  default_scope { order(created_at: :asc) }
end
