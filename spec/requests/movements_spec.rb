require 'rails_helper'

RSpec.describe "Movements", type: :request do
  let(:company) { create :company }
  let(:user) { create( :user, company: company ) }
  let(:product) { create( :product, user: user, company: company) }
  before(:each) { sign_in user }

  describe "GET /products/id/movements/new" do
    it "render new template" do
      get new_product_movement_path(product)
      expect(response).to render_template(:new)
    end
  end

  describe "POST /products/id/movements" do
    let(:params) do
      {
        "movement" => {
          "mov_type" => "output",
          "mov_sub_type" => "purchase",
          "quantity" => "2",
          "unit_price" => "150000"
        }
      }
    end

    it "creates a new sale and redirect to show page" do
      post "/products/#{product.id}/movements", params: params
      # expect(response).to redirect_to(sales_path) --> sale next code line
      expect(response).to redirect_to(assigns(:product))
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("Movement was successfully created.")
    end
  end
end
