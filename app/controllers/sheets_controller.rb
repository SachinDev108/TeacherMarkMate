class SheetsController < ApplicationController
  before_action :set_sheet, only: [:show, :fetch_children, :child_detail, :update_detail]
  def index
    @sheets = current_teacher.sheets
  end

  def new
    @sheet = Sheet.new
  end

  def create
    @sheet = current_teacher.sheets.new(sheet_params)
    if @sheet.save
      flash[:notice] = "Saved successfully"
      redirect_to :action => 'index'
    else
      @errors = @sheet.errors.full_messages
    end
  end

  def show
    @details = @sheet.details
  end

  def fetch_children
    @details = @sheet.details
    @detail = @details.first
  end

  def child_detail
    @detail = @sheet.details.find_by_id(params[:detail])
  end

  def update_detail
    @detail = @sheet.details.find_by_id(params[:detail_id])
    @detail.update_attributes(comment: params[:detail][:comment], grade_id: params[:detail][:grade_id])
  end

  private

  def set_sheet
    @sheet = Sheet.find(params[:id])
  end

  def sheet_params
    params.require(:sheet).permit(:title, :subject_id, :teacher_id, details_attributes: [:comment, :child_id, :grade_id])
  end
end