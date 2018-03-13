class TeachersController < ApplicationController
  load_and_authorize_resource :except => [:show]

  def index
    flash[:notice] = "This is your trial period for this app"
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
end
