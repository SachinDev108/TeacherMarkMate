class ChildrenController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    current_teacher.subjects.each do |subject|
      @child.students.build(subject_id: subject.id)
    end
  end

  def create
    if @child.save
      @success = ["Child was successfully created."]
    else
      @errors = @child.errors.full_messages
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

  def child_params
    params.require(:child).permit(:name, :teacher_id, students_attributes: [ :subject_id, :_destroy] )
  end
end
