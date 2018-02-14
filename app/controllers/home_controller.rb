class HomeController < ApplicationController
  before_action :authenticate_teacher!
  def index
  	@subjects = current_teacher.subjects
  	@children = current_teacher.children
  end

end