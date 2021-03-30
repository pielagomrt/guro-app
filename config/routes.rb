Rails.application.routes.draw do
  devise_for :teachers

  root 'dashboard#root'
  get '/dashboard', to: 'dashboard#dashboard', as: 'dashboard'

  resources :students

  # STUDENT SUBMODELS
  get '/students/:id/homeworks', to: 'students#view_homeworks', as: 'view_student_homeworks'
  get '/students/:id/seatworks', to: 'students#view_seatworks', as: 'view_student_seatworks'
  get '/students/:id/projects', to: 'students#view_projects', as: 'view_student_projects'
  get '/students/:id/exams', to: 'students#view_exams', as: 'view_student_exams'
  get '/students/:id/absences', to: 'students#view_absences', as: 'view_student_absences'

  # FORMS
  get '/new/section', to: 'form#new_section', as: 'new_section_form'
  get '/new/attendance/:section_id', to: 'form#new_attendance', as: 'new_attendance_form'
  get '/new/seatwork/:section_id', to: 'form#new_seatwork', as: 'new_seatwork_form'
  get '/new/homework/:section_id', to: 'form#new_homework', as: 'new_homework_form'
  get '/new/project/:section_id', to: 'form#new_project', as: 'new_project_form'
  get '/new/exam/:section_id', to: 'form#new_exam', as: 'new_exam_form'
end
