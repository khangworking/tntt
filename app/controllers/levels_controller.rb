class LevelsController < ApplicationController
  def index
    @levels = Level.joins(:active_people).where(name: Level::STUDENT_NAMES).distinct.order(sort_order: :asc)
  end

  def show
    @level = Level.find(params[:id])
    @people = Person.joins(:level).where(levels: { id: @level }).where(active: true).order_name_alphabel
    @leaders = Person.joins(:manage_levels).where(managers: { level_id: @level }).order_name_alphabel
    @roles = Manager.where(level_id: @level).index_by(&:person_id)
  end

  def export
    @people = Person.joins(:level).where(levels: { id: params[:id] }).where(active: true).order_name_alphabel
    mapped_columns = {
      christain_name: 'Tên Thánh',
      fullname: 'Họ và Tên',
      level_name: 'Ngành/Lớp',
      localed_gender: "Giới tính"
    }
    respond_to do |format|
      format.html { head :no_content }
      format.xls do
        send_data Person.to_csv(mapped_columns, @people), filename: "danhsachlop.xls"
      end
    end
  end
end
