class Admin::ProfilesController < AdminController
  def update
    if current_user.person.update(edit_params)
      flash[:success] = "Saved"
      redirect_to edit_admin_profiles_path
    else
      flash[:danger] = "Fail save"
      render :edit
    end
  end

  private

  def edit_params
    params.require(:person).permit(:christain_name, :feastday, :fullname, :gender, :phone, :level_id, :address, :birthday)
  end
end
