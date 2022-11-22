class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @products = Product.sale_priced.ordered
    @company = Company.find_by(name: "Coopkahawa")
  end
end
