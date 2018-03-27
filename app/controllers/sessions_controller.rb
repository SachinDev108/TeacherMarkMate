class SessionsController < Devise::SessionsController
  before_action :check_subcription, only: [:create]

  private

  def check_subcription
    teacher = Teacher.find_by_email(params[:teacher][:email])
    unless (teacher && teacher.plan && teacher.plan.status) || teacher.try(:is_teacher?)
      flash[:notice] = "Please sign up first"
      redirect_to new_teacher_registration_path
    end
  end
end