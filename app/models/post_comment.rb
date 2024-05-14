class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
    
  validates :comment, length: { in: 1..80 } #文字数のバリデーション
end
