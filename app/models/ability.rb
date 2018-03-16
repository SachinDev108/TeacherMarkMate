class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.is_plan_active?
        if user.is_head?
          can :manage, Teacher, parent_id: user.id
        end
        can :manage, Child, teacher_id: user.id
        can :manage, Subject, teacher_id: user.id
        can :manage, Sheet, teacher_id: user.id
      else
        if user.is_head?
          can :read, Teacher, parent_id: user.id
        end
        can :read, Child, teacher_id: user.id
        can :read, Subject, teacher_id: user.id
        can :read, Sheet, teacher_id: user.id
        can [:report, :report_details], Sheet, teacher_id: user.id
      end
    end
  end
end
