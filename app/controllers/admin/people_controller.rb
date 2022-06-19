class Admin::PeopleController < AdminController
  def index
    @people = Person.order_name_alphabel.includes(:level)
    @people = @people.where(level_id: params[:level_id]) if params[:level_id].present?
    @people = @people.page(params[:page]).per(params[:per] || 25)
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(edit_params)
      respond_to do |format|
        format.html do
          flash[:success] = 'Updated'
          redirect_to admin_people_path
        end
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html do
          flash[:success] = 'Fail update'
          redirect_to admin_people_path
        end
        format.turbo_stream
      end
    end
  end

  private

  def edit_params
    params.require(:person).permit(:active)
  end
end
