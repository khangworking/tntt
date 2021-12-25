class Managers::Levels::PeoplePresencesController < ManagersController
  def index
    @level = Level.includes(:active_people).find(params[:level_id])
    @presences = PeoplePresence.includes(user: :person).where(level_id: params[:level_id])
    @people_hash = @presences.each_with_object({}) do |presence, results|
      presence.person_ids.each do |id|
        results[id.to_i] ||= 0
        results[id.to_i] += 1
      end
    end
  end
end
