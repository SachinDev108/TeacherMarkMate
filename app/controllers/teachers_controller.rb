class TeachersController < ApplicationController
  load_and_authorize_resource :except => [:show]
  before_action :check_plan, only: [:new, :create_teacher, :update]

  def index
    
  end

  def new
  end

  def create_teacher
    @teacher = current_teacher.sub_teachers.new(teacher_params)
    if @teacher.save
      @success = ["Teacher was successfully created."]
    else
      @errors = @teacher.errors.full_messages
    end
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      @success = ["Teacher was successfully updated."]
    else
      @errors = @subject.errors.full_messages
    end
    fetch_sub_teacher
  end

  def destroy
    @teacher.destroy
    fetch_sub_teacher
  end

  def teacher_subscription
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def fetch_sub_teacher
    @teachers = current_teacher.sub_teachers
  end

  def check_plan
    if current_teacher.plan.is_individual?
      flash[:notice] = "You are not eligible for create teachers because your current plan is individual"
      render :js => "window.location = '/'"
    elsif current_teacher.plan.no_of_users == current_teacher.sub_teachers.count
      flash[:notice] = "Your no of users limit is over"
      render :js => "window.location = '/'"
    end
  end
end
