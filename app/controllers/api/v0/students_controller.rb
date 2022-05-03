class Api::V0::StudentsController < ApiApplicationController
  before_action :authenticate_user!

  def index
    page = params[:page].presence || 1
    per = params[:per].presence || 50
    level = params[:level].presence
    @resources = Person.includes(:level).students.where(active: true)
    @resources = @resources.where(levels: { id: level }) if level
    @resources = @resources.order_name_alphabel.page(page).per(per)
  end

  def show
    @student = Person.students.where(active: true).find(params[:id])
  end
end
