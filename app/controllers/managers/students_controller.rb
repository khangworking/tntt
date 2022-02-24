module Managers
  class StudentsController < ManagersController
    def index
      @students = Person.where(active: true)
                        .includes(:level)
                        .where(levels: { name: Level::STUDENT_NAMES })
      @students = @students.where(gender: params[:gender]) if params[:gender].present?
      @students = @students.where(levels: { id: params[:level_id] }) if params[:level_id].present?
      @students = @students.order_name_alphabel
                           .page(params[:page])
                           .per(25)
    end
  end
end
