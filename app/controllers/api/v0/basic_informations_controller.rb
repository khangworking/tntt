class Api::V0::BasicInformationsController < ApiApplicationController
  before_action :authenticate_user!

  def show
    @teachers_count = Person.joins(:level).where(levels: { name: %i[tro_uy tro_ta] }).count
    @seniors_count = Person.joins(:level).where(levels: { name: Level::LEADER_NAMES }).count
    @students_count = Person.joins(:level).where(levels: { name: Level::STUDENT_NAMES }).count
    @feastday = Person.next_feastday_persons
  end
end
