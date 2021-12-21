class Managers::ScoresController < ManagersController
  def show
    @score = Score.includes(level: :active_people).find(params[:id])
    @score_cells = @score.score_cells.group_by do |cell|
      [l(cell.applied_date, format: :default), cell.person_id]
    end
  end
end
