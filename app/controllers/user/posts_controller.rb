class User::PostsController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @user = current_user
    @tag_list = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] ='投稿が完了しました'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user = current_user
  end

  def update
    @post = Post.find(params[:id])
    # ①下書きの更新（公開）の場合
    @post.assign_attributes(post_params)
    if !@post.is_draft?
      # 公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      if @post.save(context: :publicize)
         flash[:notice] = "投稿を更新しました！"
         redirect_to post_path(@post.id)
      else
        #@post.status = :is_draft
        flash[:notice] = "投稿を更新できませんでした。入力内容をご確認のうえ再度お試しください"
        render :edit
      end
    # ②非公開投稿の更新の場合
    else
      if @post.save
        flash[:notice] = "投稿を更新しました！"
        redirect_to post_path(@post.id)
      else
        flash[:notice] =  "投稿を更新できませんでした。再度お試しください"
        render :edit
      end
      if @post.update(post_params)
         redirect_to posts_path
      else
       render :edit
      end
    end
  end


  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new #コメントの取得
    @post_tags = @post.tags
  end

  def destroy
    post = Post.find(params[:id])  # データ（レコード）を1件取得
    post.destroy  # 削除
    redirect_to posts_path  # 投稿一覧画面へリダイレクト
  end
  #カテゴリに関連するページ
  def dreams
    @posts = Post.all
  end

  def meisekimu
    @posts = Post.all
  end

  def sleeps
    @posts = Post.all
  end

  def others
    @posts = Post.all
  end


  private
    def post_params
      params.require(:post).permit(:body, :category, :status)
    end

    def ensure_user
      # ログインユーザーが対象の投稿を所有しているかどうかを確認するための処理
      post = Post.find(params[:id])
      unless post.user == current_user
        redirect_to root_path, alert: "権限がありません。"
      end
    end
end
