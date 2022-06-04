class Api::V0::LeadersController < ApiApplicationController
  before_action :authenticate_user!

  def index
    page = params[:page].presence || 1
    per = params[:per].presence || 50
    level = params[:level].presence
    @resources = Person.includes(:level).where(levels: { name: Level::LEADER_NAMES }).where(active: true)
    @resources = @resources.where(levels: { id: level }) if level
    @resources = @resources.order_name_alphabel.page(page).per(per)
  end
end
