class HomeController < ApplicationController
  before_action :authenticate_teacher! , :except => [:subscription]
  def index
    @subjects = current_teacher.subjects
    @children = current_teacher.children
    @details_count = current_teacher.details.updated_in_between((Time.zone.now - 30.days), Time.zone.now).count
  end

  def subscription
  end

end
