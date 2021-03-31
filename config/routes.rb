Rails.application.routes.draw do
  devise_for :teachers

  root 'dashboard#root'
  get '/dashboard', to: 'dashboard#dashboard', as: 'dashboard'

  # SECTION SUBMODELS
  get '/sections', to: 'sections#index', as: 'sections'
  get '/sections/:id', to: 'sections#show', as: 'section'
  get '/sections/:id/seatworks', to: 'sections#view_seatworks', as: 'view_section_seatworks'
  get '/sections/:id/homeworks', to: 'sections#view_homeworks', as: 'view_section_homeworks'
  get '/sections/:id/projects', to: 'sections#view_projects', as: 'view_section_projects'
  get '/sections/:id/exams', to: 'sections#view_exams', as: 'view_section_exams'
  get '/sections/:id/attendances', to: 'sections#view_attendances', as: 'view_section_attendances'

  # SECTION PROCESSES
  put '/sections/:id/update', to: 'section_processes#update_section', as: 'section_update'
  put '/sections/:id/attendances/:attendance_id/update', to: 'section_processes#update_section_attendance', as: 'section_attendance_update'
  put '/sections/:id/seatworks/:seatwork_id/update', to: 'section_processes#update_section_seatwork', as: 'section_seatwork_update'
  put '/sections/:id/homeworks/:homework_id/update', to: 'section_processes#update_section_homework', as: 'section_homework_update'
  put '/sections/:id/projects/:project_id/update', to: 'section_processes#update_section_project', as: 'section_project_update'
  put '/sections/:id/exams/:exam_id/update', to: 'section_processes#update_section_exam', as: 'section_exam_update'
  delete '/sections/:id/delete', to: 'section_processes#destroy_section', as: 'section_delete'
  delete '/sections/:id/seatworks/:seatwork_id/delete', to: 'section_processes#destroy_section_seatwork', as: 'section_seatwork_delete'
  delete '/sections/:id/homeworks/:homework_id/delete', to: 'section_processes#destroy_section_homework', as: 'section_homework_delete'
  delete '/sections/:id/projects/:project_id/delete', to: 'section_processes#destroy_section_project', as: 'section_project_delete'
  delete '/sections/:id/exams/:exam_id/delete', to: 'section_processes#destroy_section_exam', as: 'section_exam_delete'
  delete '/sections/:id/attendances/:attendance_id/delete', to: 'section_processes#destroy_section_attendance', as: 'section_attendance_delete'

  # STUDENT SUBMODELS
  get '/sections/:id/students', to: 'students#index', as: 'students'
  get '/sections/:id/students/:student_id', to: 'students#show', as: 'student'
  get '/sections/:id/students/:student_id/homeworks', to: 'students#view_homeworks', as: 'view_student_homeworks'
  get '/sections/:id/students/:student_id/seatworks', to: 'students#view_seatworks', as: 'view_student_seatworks'
  get '/sections/:id/students/:student_id/projects', to: 'students#view_projects', as: 'view_student_projects'
  get '/sections/:id/students/:student_id/exams', to: 'students#view_exams', as: 'view_student_exams'
  get '/sections/:id/students/:student_id/absences', to: 'students#view_absences', as: 'view_student_absences'

  # FORMS
  get '/new/section', to: 'form#new_section', as: 'new_section_form'
  get '/new/attendance/:section_id', to: 'form#new_attendance', as: 'new_attendance_form'
  get '/new/seatwork/:section_id', to: 'form#new_seatwork', as: 'new_seatwork_form'
  get '/new/homework/:section_id', to: 'form#new_homework', as: 'new_homework_form'
  get '/new/project/:section_id', to: 'form#new_project', as: 'new_project_form'
  get '/new/exam/:section_id', to: 'form#new_exam', as: 'new_exam_form'
end
