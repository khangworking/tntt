class Managers::ScoresController < ManagersController
  layout 'blank'

  def show
    @dates = (Date.new(2022, 9)..Date.new(2023, 2)).select { |date| date.thursday? || date.sunday? }
    @people = Person.includes(:level).where(active: true)
    @people = @people.where(levels: { id: params[:level_id] }) if params[:level_id]
  end
end
