class Managers::Levels::PeoplePresencesController < ManagersController
  def new
    @level = Level.includes(:active_people).find(params[:level_id])
  end

  def create
    date_chain = l(Time.zone.now.to_date, format: :chain)
    LevelScore.create_presence_scores(
      person_ids: params[:person_ids],
      date_chain: date_chain,
      level_id: params[:level_id]
    )
    redirect_to new_managers_level_people_presence_path(level_id: params[:level_id])
  end

  def index
    @resources = LevelScore.where(level_id: params[:level_id])
                           .group('level_id, date_chain')
                           .select('date_chain, count(*) as count')
                           .map do |ls|
                             [ls.date_chain, ls.count]
                           end.to_h
  end
end
