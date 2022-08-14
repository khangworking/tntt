class PeopleController < ApplicationController
  def new
    @person = Person.new(level_id: params[:level_id])
  end

  def create
    @person = Person.new(create_params)
    @person.save
  end

  private

  def create_params
    params
      .require(:person)
      .permit(:fullname, :christain_name, :phone, :birthday, :feastday, :gender, :level_id)
  end
end
