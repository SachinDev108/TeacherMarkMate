class HomeController < ApplicationController
  before_action :authenticate_teacher! , :except => [:subscription]
  def index
  	@subjects = current_teacher.subjects
  	@children = current_teacher.children
  end

  def subscription
  end

end