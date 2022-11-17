require 'rails_helper'

RSpec.describe "Customers", type: :request do
  let(:company) { create :company }
  let(:user) { create( :user, company: company ) }

  before(:each) { sign_in user }

  describe "GET /customers" do
    it "render customer index" do
      get customers_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /customers/new" do
    it "render new template" do
      get new_customer_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /customers" do
    let(:params) do
      {
        "customer" => {
          "name" => "test",
          "id_number" => "1234",
          "email" => "test@test.com",
          "phone_number" => "1234",
          "address" => "Address"
        }
      }
    end

    it "creates a new product and redirect to show page" do
      post '/customers', params: params
      expect(response).to redirect_to(assigns(:customers))
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include("Customer was successfully created.")
    end
  end
end
