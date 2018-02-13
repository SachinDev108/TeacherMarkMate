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
      flash[:notice] = "Subject was successfully created."
    end 
    @subjects = current_teacher.subjects
  end

  def edit
  end

  def update
  	if @subject.update(subject_params)
      flash[:notice] = "Subject was successfully updated."
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