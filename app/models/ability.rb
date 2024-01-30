class Ability
  include CanCan::Ability

  def initialize(current_user)
    @user = current_user || User.new

    can :read, :all
    can :manage, Expense
    can :manage, Payment, author: @user
    can :manage, Allocation
  end
end
