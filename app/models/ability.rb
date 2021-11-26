class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      admin
    elsif user.manager?
      manager(user)
    else
      anonymous
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

  def anonymous
    can :read, Person, { active: true }
  end

  def manager(user)
    anonymous
    can :show, :manager_dashboards
    can :manage, Level, managers: { person_id: user.person }
    can :read, :create, Person
    can :update, Person, user_id: user.id
    can :update, Person do |person|
      user.manage_levels.where(level_id: person.level_id).exists?
    end

    if user.person.leader? || user.person.vice_leader?
      can :index, :manage_people
      can :manage, Level, name: Level::STUDENT_NAMES
    end

    if user.manage_levels.any?
      can :index, :manage_people
    end
  end

  def admin
    can :manage, :all
  end
end
