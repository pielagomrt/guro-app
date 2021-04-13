class DashboardController < ApplicationController
  before_action :authenticate_teacher!, except: [:root]

  def root
    render layout: 'landing'
  end

  def dashboard
    @youtube_videos = Youtube.search(current_teacher.subject)
  end
end
