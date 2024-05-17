# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # ゲストユーザーの場合は新しいUserオブジェクトを作成

    if user.admin? # admin権限を持っている場合
      can :access, :rails_admin   # adminダッシュボードへのアクセス権限を与える
      can :manage, :all
    end
  end


  #def initialize(user)
    #def initialize(user)
    #if user.try(:admin?)
      #can :access, :rails_admin
      #can :manage, :all
    #end
    #end
  #end
end
