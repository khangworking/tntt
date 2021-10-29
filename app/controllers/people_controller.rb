class PeopleController < ApplicationController
  def create
    @person = Person.new(create_params)
    @person.save
  end

  private

  def create_params
    params.require(:person).permit(:fullname, :christain_name, :phone, :birthday, :feastday)
  end
end
