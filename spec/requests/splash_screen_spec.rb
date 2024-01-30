require 'rails_helper'

RSpec.describe 'SplashScreens', type: :request do
  describe 'GET /index' do
    it 'should be response successull' do
      get unauthenticated_root_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render the index template' do
      get unauthenticated_root_path
      expect(response).to render_template(:index)
    end

    it 'should include the app name' do
      get unauthenticated_root_path
      expect(response.body).to include('Budgetify')
    end
  end
end
