class Admin::PeopleController < AdminController
  def index
    @people = filtered_resource.page(params[:page]).per(params[:per] || 25)
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(edit_params)
      respond_to do |format|
        format.html do
          flash[:success] = 'Updated'
          redirect_to edit_admin_person_path(@person)
        end
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html do
          flash[:success] = 'Fail update'
          redirect_to edit_admin_person_path(@person)
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

  def export
    mapped_columns = {
      christain_name: 'Tên Thánh',
      fullname: 'Họ và Tên',
      level_name: 'Lớp',
      localed_gender: "Giới tính"
    }
    send_data Person.to_csv(mapped_columns, filtered_resource), filename: "#{params[:filename]}.csv", type: "text/csv"
  end

  def edit
    @person = Person.find(params[:id])
  end

  private

  def edit_params
    params.require(:person).permit(:active, :christain_name, :feastday, :fullname, :gender, :phone, :level_id, :address, :birthday)
  end

  def create_params
    params.require(:person).permit(:christain_name, :feastday, :fullname, :gender, :phone, :level_id, :address, :birthday)
  end

  def filtered_resource
    @people = Person.order_name_alphabel.includes(:level)
    if params[:level_ids].present?
      ids = params[:level_ids]
      ids = ids.split(' ') if ids.is_a?(String)
      @people = @people.where(level_id: ids)
    end
    @people = @people.where(active: params[:active].presence || true) if params[:active] != 'all'
    @people
  end
end
