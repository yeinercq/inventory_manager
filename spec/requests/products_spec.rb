require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:company) { create :company }
  let(:user) { create( :user_with_profile, company: company ) }


  before(:each) { sign_in user }

  describe "GET /products" do
    it "render invoices index" do
      get products_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /products/new" do
    it "render new template" do
      get new_product_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /products" do
    let(:provider) { create :provider }
    let(:category) { create :category }
    let(:params) do
      {
        "product" => {
          "name" => "Produccion",
          "brand" => "Marca",
          "unit" => "bulto",
          "size" => "50kg",
          "provider_id" => provider.id.to_s,
          "price" => "150000",
          "initial_quantity" => "100",
          "description" => "description",
          "category_id" => category.id
        }
      }
    end

    it "creates a new product and redirect to show page" do
      post '/products', params: params
      expect(response).to redirect_to(assigns(:products))
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include(I18n.t('products.created_success'))
    end
  end
end
