class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    #if user.admin?
    # can :manage, :all
    #else
    # can :read, :all
    #end

    if user.admin?
      can [:destroy], User
    end
    can [:read, :edit, :update, :destroy], Plan, user_id: user.id
    can [:read, :edit, :update, :destroy], FocusArea, user_id: user.id
    can [:read, :edit, :update, :destroy], Task, user_id: user.id
    can [:read, :edit, :update, :destroy], Schedule, user_id: user.id
    can [:read, :edit, :update, :destroy], Lesson, user_id: user.id

    can(:view, Achievement) { |a| user.id == a.user_id || a.privacy == Achievement::SHOW_TO_PUBLIC }
    can(:view_on_profile, Achievement) { |a| a.privacy == Achievement::SHOW_TO_PUBLIC }
  end

end
