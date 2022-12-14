require 'rails_helper'

RSpec.describe "Sales", type: :request do
  let(:company) { create :company }
  let(:user) { create( :user_with_profile, company: company ) }

  before(:each) { sign_in user }

  describe "GET /sales" do
    it "render sales index" do
      get sales_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /sales/new" do
    it "render new template" do
      get new_sale_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /sale" do
    let(:client) { create :customer }
    let(:params) do
      {
        "sale" => {
          "client_id" => client.id.to_s
        }
      }
    end

    it "creates a new sale and redirect to show page" do
      post '/sales', params: params
      # expect(response).to redirect_to(sales_path) --> sale next code line
      expect(response).to redirect_to(assigns(:sales))
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include(I18n.t('sales.created_success'))
    end
  end
end
