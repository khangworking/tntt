class LevelsController < ApplicationController
  def index
    @levels = Level.joins(:active_people).where(name: Level::STUDENT_NAMES).distinct.order(sort_order: :asc)
  end
end
