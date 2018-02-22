class SheetsController < ApplicationController
  before_action :set_sheet, only: [:show, :fetch_children, :child_detail, :update_detail, :destroy]
  before_action :set_subject, only: [:index, :report_details]
  def index
    @subjects = current_teacher.subjects
    if params[:subject_id]
      @sheets = current_teacher.sheets.where(subject_id: params[:subject_id])
    end
  end

  def report_details
    if params[:subject_id]
      @sheets = Sheet.get_details(params[:subject_id])
      @children = @subject.children.order('name')
    end
  end

  def new
    @sheet = Sheet.new
    @objectives = current_teacher.sheets
  end

  def create
    @sheet = current_teacher.sheets.new(sheet_params)
    if @sheet.save
      flash[:notice] = "Saved successfully"
      redirect_to :action => 'new'
    else
      @errors = @sheet.errors.full_messages
    end
  end

  def destroy
    @sheet.destroy
    redirect_to :action => 'new'
  end

  def show
    @details = @sheet.details
  end

  def fetch_children
    @details = @sheet.details.joins(:child).order("children.name asc")
    @detail = @details.first
  end

  def child_detail
    @detail = @sheet.details.find_by_id(params[:detail])
  end

  def update_detail
    @detail = @sheet.details.find_by_id(params[:detail_id])
    @detail.update_attributes(comment: params[:detail][:comment], grade_id: params[:detail][:grade_id])
  end

  def report
    @sheets = current_teacher.sheets
    @subjects = current_teacher.subjects
  end

  private

  def set_sheet
    @sheet = Sheet.find(params[:id])
  end

  def set_subject
    @subject = current_teacher.subjects.find_by_id(params[:subject_id])
  end

  def sheet_params
    params.require(:sheet).permit(:title, :subject_id, :teacher_id, :date, details_attributes: [:comment, :child_id, :grade_id])
  end
end