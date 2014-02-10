class Ability
  include CanCan::Ability

  def initialize(user)
    #user ||= User.new # guest user (not logged in)
    #if user.admin?
    # can :manage, :all
    #else
    # can :read, :all
    #end

    can [:read, :edit, :update, :destroy], Plan, :user_id => user.id
    can [:read, :edit, :update, :destroy], FocusArea, :user_id => user.id
    can [:read, :edit, :update, :destroy], Task, :user_id => user.id
    can [:read, :edit, :update, :destroy], Schedule, :user_id => user.id
    can [:read, :edit, :update, :destroy], Lesson, :user_id => user.id
  end

end
