require 'rails_helper'

RSpec.describe 'SplashScreens', type: :request do
  describe 'GET /index' do
    before(:each) do
      get unauthenticated_root_path
    end

    it 'responds successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the app name' do
      expect(response.body).to include('FinanceFlick')
    end
  end
end
