class SheetsController < ApplicationController
  before_action :set_sheet, only: [:index]
  before_action :set_subject, only: [:index, :report_details]
  load_and_authorize_resource

  def index
    @subjects = current_teacher.subjects
    if params[:subject_id]
      @sheets = current_teacher.sheets.where(subject_id: params[:subject_id])
    end
  end

  def report_details
    if params[:subject_id]
      @sheets = Sheet.get_details(params[:subject_id])
      @children = @subject.children.order('name').ids
    end
  end

  def new
    @objectives = current_teacher.sheets.order('created_at DESC')
  end

  def create
    if @sheet.details.present? && @sheet.save
      flash[:notice] = "Saved successfully"
      redirect_to :action => 'new'
    else
      @errors = @sheet.errors.full_messages
    end
  end

  def destroy
    @sheet.destroy
    @objectives = current_teacher.sheets.order('created_at DESC')
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
    @sheet = Sheet.find(params[:sheet_id])
    @detail = @sheet.details.find_by_id(params[:detail_id])
    @detail.update_attributes(comment: params[:detail][:comment], grade_id: params[:detail][:grade_id]) if params[:detail_ids].blank?
    @sheet.details.where(id: params[:detail_ids]).update_all(comment: params[:detail][:comment], grade_id: params[:detail][:grade_id])
    respond_to do |format|
      format.js 
      format.json do
        render json: { text: params[:detail][:comment], ids: params[:detail_ids], id: @detail.try(:id) }.to_json
      end
    end
  end

  def report
    @sheets = current_teacher.sheets
    @subjects = current_teacher.subjects
  end

  private

  def set_sheet
    if params[:id].present?
      @sheet = current_teacher.sheets.find_by_id(params[:id])
    end
  end

  def set_subject
    @subject = current_teacher.subjects.find_by_id(params[:subject_id])
  end

  def sheet_params
    params.require(:sheet).permit(:title, :subject_id, :teacher_id, :date, details_attributes: [:comment, :child_id, :grade_id])
  end
end