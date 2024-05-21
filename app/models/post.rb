class Post < ApplicationRecord
  belongs_to :user,          optional: true
  has_many :post_comments,   dependent: :destroy #Post.commentsで、投稿が所有するコメントを取得できる。
  has_many :likes,           dependent: :destroy

  scope :public_posts, -> { where(status: self.statuses[:is_public]) }
  scope :private_posts, -> { where(status: self.statuses[:is_private]) }

  with_options presence: true, on: :publicize do
  end

  enum status: { is_public: 0, is_private: 1 } #1が下書き


  validates :body, length: { in: 3..80 } #投稿本文のバリデーション３〜８０文字


  def like?(user)
   likes.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
      Post.where('body LIKE ?', '%' + word + '%')
  end

  def self.categories
    {
      dreams: "夢日記",
      meisekimu: "明晰夢",
      sleeps: "睡眠",
      others: "その他"
    }
  end
end
