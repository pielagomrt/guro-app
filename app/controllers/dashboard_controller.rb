class DashboardController < ApplicationController
  before_action :authenticate_teacher!, except: [:root]

  def root
    render layout: 'landing'
  end

  def dashboard; end
end
