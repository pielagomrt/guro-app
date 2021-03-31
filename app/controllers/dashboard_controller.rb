class DashboardController < ApplicationController
  before_action :authenticate_teacher!, except: [:root]

  def root; end

  def dashboard; end
end
