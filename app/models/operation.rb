class Operation < ApplicationRecord
  default_scope { order(created_at: :asc) }

  include ActionView::Helpers::DateHelper
  def time_from_last_sync
    time_ago_in_words(updated_at)
  end
end
