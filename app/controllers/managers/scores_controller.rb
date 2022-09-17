class Managers::ScoresController < ManagersController
  layout 'blank'

  def show
    @dates = (Date.new(2022, 9)..Date.new(2023, 2)).select { |date| date.sunday? }
    @scores = LevelScore.where(date_chain: @dates.map { |date| l(date, format: :chain) }).group_by do |score|
      [score.person_id, score.date_chain, score.score_type]
    end
    @people = Person.includes(:level).where(active: true)
    @people = @people.where(levels: { id: params[:level_id] }) if params[:level_id]
  end

  def create_presence_score
    @score = LevelScore.new(create_presence_params)
    @score.save
    respond_to do |format|
      format.html { head :no_content }
      format.turbo_stream
    end
  end

  private

  def create_presence_params
    params.require(:level_score).permit(
      :score_number, :note, :date_chain, :level_id, :person_id
    ).tap do |whitelist|
      whitelist[:score_type] = 'presence'
    end
  end
end
