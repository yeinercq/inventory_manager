require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:company) { create :company }
  let(:sale) { create :sale, user: user }
  let(:user) { create( :user, company: company ) }

  before(:each) { sign_in user }

  describe "GET /sales/:id/imtes/new" do
    it "render new template" do
      get new_sale_item_path(sale)
      expect(response).to render_template(:new)
    end
  end

  describe "POST /sales/:id/items" do
    let(:product) { create :product }
    let(:params) do
      {
        "item" => {
          "product_id" => product.id.to_s,
          "quantity" => "1",
          "unit_price" => "12"
        }
      }
    end

    it "creates a new item and redirect to sale show page" do
      post "/sales/#{sale.id}/items", params: params
      expect(response).to redirect_to(assigns(:sale))
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("Item was successfully created.")
    end
  end
end
