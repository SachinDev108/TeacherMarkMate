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
    ids = @child.subjects.pluck(:id)
    subjects = current_teacher.subjects.where.not(id: ids)
    subjects.each do |subject|
      @child.students.build(subject_id: subject.id)
    end
  end

  def update
    @child.students.delete_all
    if @child.update(child_params)
      @success = ["Subject was successfully updated."]
    else
      @errors = @child.errors.full_messages
    end
     @child = current_teacher.subjects
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
    params.require(:child).permit(:name, :teacher_id, students_attributes: [ :subject_id, :_destroy] )
  end
end
