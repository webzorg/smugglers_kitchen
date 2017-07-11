class HomeController < ApplicationController
  def index
    @contractors_by_debt = Contractor.by_debt_descending.first(50).reverse
    respond_to do |format|
      format.html { render home_index_path }
      format.json { render home_index_path }
    end
  end
end
