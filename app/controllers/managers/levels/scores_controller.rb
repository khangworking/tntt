class Managers::Levels::ScoresController < ManagersController
  before_action :find_level, :find_people

  def index
    @scores = LevelScore.where(level_id: @level).group_by(&:person_id).map do |person_id, level_scores|
      [person_id, level_scores.group_by(&:date_chain)]
    end.to_h
    @dates = LevelScore.where(level_id: @level).group(:date_chain, :level_id).select('date_chain, level_id, count(*) as count')
  end

  private

  def find_level
    @level = Level.find(params[:level_id])
  end

  def find_people
    @people = Person.where(active: true).where(level_id: @level).order_name_alphabel
  end
end
