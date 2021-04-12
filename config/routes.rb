Rails.application.routes.draw do
  devise_for :teachers, 
    controllers:  { sessions: 'teachers/sessions', registrations: 'teachers/registrations', confirmations: 'teachers/confirmations', passwords: 'teachers/passwords' },
    path_names: { sign_in: 'signin', sign_up: 'signup', sign_out: 'signout' }

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
  post '/sections/:id/report', to: 'section_processes#section_report_to_email', as: 'section_report'
  get '/sections/:id/report', to: 'section_processes#download_report', as: 'section_report_dowload'
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

  # STUDENT PROCESSES
  post '/sections/:id/students/:student_id/report', to: 'student_processes#student_report_to_email', as: 'student_report'
  get '/sections/:id/students/:student_id/report', to: 'student_processes#download_report', as: 'student_report_dowload'
  put '/sections/:id/students/:student_id/update', to: 'student_processes#update_student', as: 'student_update'
  put '/sections/:id/students/:student_id/seatworks/:seatwork_id', to: 'student_processes#update_student_seatwork', as: 'student_update_seatwork'
  put '/sections/:id/students/:student_id/homeworks/:homework_id', to: 'student_processes#update_student_homework', as: 'student_update_homework'
  put '/sections/:id/students/:student_id/projects/:project_id', to: 'student_processes#update_student_project', as: 'student_update_project'
  put '/sections/:id/students/:student_id/exams/:exam_id', to: 'student_processes#update_student_exam', as: 'student_update_exam'
  delete '/sections/:id/students/:student_id/delete', to: 'student_processes#destroy_student', as: 'student_delete'
  delete '/sections/:id/students/:student_id/seatworks/:seatwork_id/delete', to: 'student_processes#destroy_student_seatwork', as: 'student_delete_seatwork'
  delete '/sections/:id/students/:student_id/homeworks/:homework_id/delete', to: 'student_processes#destroy_student_homework', as: 'student_delete_homework'
  delete '/sections/:id/students/:student_id/projects/:project_id/delete', to: 'student_processes#destroy_student_project', as: 'student_delete_project'
  delete '/sections/:id/students/:student_id/exams/:exam_id/delete', to: 'student_processes#destroy_student_exam', as: 'student_delete_exam'
  delete '/sections/:id/students/:student_id/absences/:absent_id/delete', to: 'student_processes#destroy_student_attendance', as: 'student_delete_attendance'
  
  # FORMS
  get '/new/section', to: 'form#new_section', as: 'new_section_form'
  get '/new/grading-system', to: 'form#new_grading_system', as: 'new_grading_system_form'
  get '/new/seatwork/:section_id', to: 'form#new_seatwork', as: 'new_seatwork_form'
  get '/new/homework/:section_id', to: 'form#new_homework', as: 'new_homework_form'
  get '/new/project/:section_id', to: 'form#new_project', as: 'new_project_form'
  get '/new/exam/:section_id', to: 'form#new_exam', as: 'new_exam_form'
  get '/new/attendance/:section_id', to: 'form#new_attendance', as: 'new_attendance_form'

  # PROCESS FORMS
  post '/new/section', to: 'creation_processes#create_section', as: 'create_section'
  post '/new/grading-system', to: 'creation_processes#create_grading_system', as: 'create_grading_system'
  post '/new/seatwork/:section_id', to: 'creation_processes#create_seatwork', as: 'create_seatwork'
  post '/new/homework/:section_id', to: 'creation_processes#create_homework', as: 'create_homework'
  post '/new/project/:section_id', to: 'creation_processes#create_project', as: 'create_project'
  post '/new/exam/:section_id', to: 'creation_processes#create_exam', as: 'create_exam'
  post '/new/attendance/:section_id/', to: 'creation_processes#create_attendance', as: 'create_attendance'
end
