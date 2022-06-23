class Admin::PeopleController < AdminController
  def index
    @people = Person.order_name_alphabel.includes(:level)
    @people = @people.where(level_id: params[:level_ids]) if params[:level_ids].present?
    @people = @people.where(active: params[:active]) if params[:active].present?
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

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(create_params)
    if @person.save
      redirect_to admin_people_path
    else
      flash.now[:danger] = @person.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def edit_params
    params.require(:person).permit(:active)
  end

  def create_params
    params.require(:person).permit(:christain_name, :feastday, :fullname, :gender, :phone, :level_id, :address, :birthday)
  end
end
