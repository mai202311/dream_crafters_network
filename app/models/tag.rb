class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy #postを削除でタグも消えるように
  has_many :posts, through: :post_tags #through：中間テーブルの取得


  validates :name, length: { in: 2..10 }, uniqueness: true #文字数のバリデーションと一意性を保つバリデーション
end

