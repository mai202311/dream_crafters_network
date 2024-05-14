class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest #ゲストサインイン
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy  #User.commentsで、ユーザーの所有するコメントを取得
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post　#throughで中間テーブルの取得
  validates :name, uniqueness: true, length: { in: 1..10 } #nameに一意性を持たせる、文字数のバリデーション

  def self.looks(search, word) #検索機能
      User.where('name LIKE ?', '%' + word + '%')
  end

  def draft_posts #下書き機能
    self.posts.drafts
  end
end