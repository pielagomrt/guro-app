Rails.application.routes.draw do
  devise_for :teachers, controllers: { :registrations => :registrations }
end
