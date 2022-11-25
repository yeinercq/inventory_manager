class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @home_page_products = Product.sale_priced.ordered
    @team_users = User.has_profile
  end
end
