require 'cancan'

class Ability
  include CanCan::Ability

  include Hydra::Ability

  def custom_permissions(user, session)

    if user.user_key == 'justin@example.com'
      can :manage, :all
    end

  end

end
