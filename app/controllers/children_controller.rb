class ChildrenController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @children = current_teacher.children
  end

  def new
    @child = Child.new
  end

  def create
    @child = current_teacher.children.new(child_params)
    if @child.save
      flash[:notice] = "Child was successfully created."
    end 
    @children = current_teacher.children
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

	def set_student
	  @child = Child.find(params[:id])
	end

	def child_params
	  params.require(:child).permit(:name, :teacher_id)
	end

end