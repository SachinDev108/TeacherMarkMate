class ChildrenController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @children = current_teacher.children
  end

  def new
    @child = Child.new
    current_teacher.subjects.each do |subject|
      @child.students.build(subject_id: subject.id)
    end
  end

  def create
    @child = current_teacher.children.new(child_params)
    if @child.save
      @success = ["Child was successfully created."]
    else
      @errors = @subject.errors.full_messages
    end 
    @children = current_teacher.children
  end

  def edit
  end

  def update
  end

  def destroy
    @child.destroy
    @children = current_teacher.children
  end

  private

	def set_student
	  @child = Child.find(params[:id])
	end

	def child_params
	  params.require(:child).permit(:name, :teacher_id, students_attributes: [ :subject_id, :_destroy ] )
	end

end