class User::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    if current_user.email === 'guest@example.com'
      reset_session
      redirect_to new_user_registration_path
    else
    @my_posts = current_user.posts
    @draft_posts = current_user.draft_posts
    @like_posts = Post.joins(:likes).where(likes: {user_id: current_user.id})#joinsでpostsテーブルとlikesテーブルを結合
    end
  end

  def edit
  end

  def update
      set_user
      if @user.update(user_params)
        flash[:notice] = "ユーザーを更新しました"
        redirect_to mypage_path
      else
          flash[:alart] = "ユーザーを更新できませんでした"
          render :edit
      end
  end
  
  

  private
  def set_user
      @user = User.find(current_user.id)
  end

  def user_params
        params.require(:user).permit(:email,:name)
  end

end
