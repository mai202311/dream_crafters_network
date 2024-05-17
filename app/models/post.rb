class Post < ApplicationRecord
  belongs_to :user,          optional: true
  has_many :post_comments,   dependent: :destroy #Post.commentsで、投稿が所有するコメントを取得できる。
  has_many :likes,           dependent: :destroy
  has_many :post_tags,       dependent: :destroy
  has_many :tags,            through: :post_tags #投稿タグ、throughで中間テーブルを取得

  with_options presence: true, on: :publicize do
  end

  enum status: { is_public: 0, is_private: 1, is_draft: 2 } #1が下書き


  validates :body, length: { in: 3..80 } #投稿本文のバリデーション３〜８０文字


  def like?(user)
   likes.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
      Post.where('body LIKE ?', '%' + word + '%')
  end
end
