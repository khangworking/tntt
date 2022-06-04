class Api::V0::BasicInformationsController < ApiApplicationController
  before_action :authenticate_user!

  def show
    render json: {
      teachers_count: Person.joins(:level).where(levels: { name: %i[tro_uy tro_ta] }).count,
      seniors_count: Person.joins(:level).where(levels: { name: Level::LEADER_NAMES }).count,
      student_count: Person.joins(:level).where(levels: { name: Level::STUDENT_NAMES }).count
    }
  end
end
