class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    @subjects = current_teacher.subjects
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = current_teacher.subjects.new(subject_params)
    if @subject.save
      @success = ["Subject was successfully created."]
    else
      @errors = @subject.errors.full_messages
    end
    @subjects = current_teacher.subjects
  end

  def show
  end

  def edit
  end

  def update
    if @subject.update(subject_params)
      @success = ["Subject was successfully updated."]
    else
      @errors = @subject.errors.full_messages
    end
     @subjects = current_teacher.subjects
  end

  def destroy
    @subject.destroy
    @subjects = current_teacher.subjects
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, :teacher_id)
  end

end