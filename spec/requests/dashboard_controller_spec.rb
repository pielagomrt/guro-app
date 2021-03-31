require 'rails_helper'

RSpec.describe DashboardController, type: :request do
  let(:teacher) { create(:teacher) }

  before do
    teacher.confirm
    sign_in(teacher)
  end

  describe 'GET / dashboard#root' do
    before { get root_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders root template' do
      expect(response).to render_template(:root)
    end
  end

  describe 'GET /dashboard dashboard#dashboard' do
    before { get dashboard_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders dashboard template' do
      expect(response).to render_template(:dashboard)
    end
  end
end
