class Task < ApplicationRecord
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  #statusについてバリデーション10文字以下
  validates :status, presence: true, length: { maximum: 10 }
  
  
end
