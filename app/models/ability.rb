class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new                # guest user (not logged in)
    if user && (user.is_head?)
      can :manage, Teacher, parent_id: user.id
    end
    can :manage, Child, teacher_id: user.id
    can :manage, Subject, teacher_id: user.id
    can :manage, Sheet, teacher_id: user.id
  end
end
