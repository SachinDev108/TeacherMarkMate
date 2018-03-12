class HomeController < ApplicationController
  before_action :authenticate_teacher!
  def index
    @subjects = current_teacher.subjects
    @children = current_teacher.children
    @sheets = current_teacher.sheets
    @last_month_sheet_count = @sheets.created_in_between((Time.zone.now.beginning_of_month - 1.month), (Time.zone.now.end_of_month - 1.month)).count
    @last_month_subject_count = @subjects.created_in_between((Time.zone.now.beginning_of_month - 1.month), (Time.zone.now.end_of_month - 1.month)).count
    @last_month_child_count = @children.created_in_between((Time.zone.now.beginning_of_month - 1.month), (Time.zone.now.end_of_month - 1.month)).count
    @recent_sheets = @sheets.order("date DESC").first(5)
    @recent_details = current_teacher.details.order("updated_at DESC").first(5)
  end
end
