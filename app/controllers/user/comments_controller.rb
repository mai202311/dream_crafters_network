class User::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end


  def destroy
    comment = PostComment.find(params[:id])  # データ（レコード）を1件取得
    comment.destroy  # 削除
    redirect_to post_path(comment.post_id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
