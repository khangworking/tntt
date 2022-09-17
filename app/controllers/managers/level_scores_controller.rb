class Managers::LevelScoresController < ManagersController
  def destroy
    @score = LevelScore.find(params[:id])
    @score.destroy
  end
end
