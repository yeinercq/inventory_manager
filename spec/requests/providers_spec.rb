require 'rails_helper'

RSpec.describe "Providers", type: :request do
  let(:company) { create :company }
  let(:user) { create( :user, company: company ) }

  before(:each) { sign_in user }

  describe "GET /providers" do
    it "render provider index" do
      get providers_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /providers/new" do
    it "render new template" do
      get new_provider_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /providers" do
    let(:params) do
      {
        "provider" => {
          "name" => "test",
          "email" => "test@test.com",
          "phone_number" => "123456"
        }
      }
    end

    it "creates a new provider and redirect to show page" do
      post '/providers', params: params
      expect(response).to redirect_to(assigns(:providers))
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include(I18n.t('providers.created_success'))
    end
  end
end
