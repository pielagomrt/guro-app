require 'rails_helper'

RSpec.describe DashboardController, type: :request do
  describe 'GET / dashboard#root' do
    it 'returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'renders root template' do
      get root_path
      expect(response).to render_template(:root)
    end
  end

  describe 'GET /dashboard dashboard#dashboard' do
    it 'returns http success' do
      get dashboard_path
      expect(response).to have_http_status(:success)
    end

    it 'renders dashboard template' do
      get dashboard_path
      expect(response).to render_template(:dashboard)
    end
  end
end
