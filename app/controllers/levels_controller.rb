class LevelsController < ApplicationController
  def index
    @levels = Level.joins(:active_people).where(name: Level::STUDENT_NAMES).distinct.order(sort_order: :asc)
  end

  def show
    @level = Level.find(params[:id])
    @people = Person.joins(:level).where(levels: { id: @level }).where(active: true).order_name_alphabel
  end
end
