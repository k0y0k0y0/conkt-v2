class Profile < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  #男女の番号を保存させる
  enum sex: { 男性: 0, 女性: 1}
  #アイコンuploderを追加
  mount_uploader :icon, IconUploader
  validates :name, presence: true
  validates :sex, presence: true
  validates :age, presence: true
  validates :work, presence: true
  validates :hobby, presence: true
  validates :likes, presence: true
  validates :comment, presence: true, length: { maximum: 100 }

  def self.default_icons
    ['default_icon1.jpg', 'default_icon2.jpg', 'default_icon3.jpg', 'default_icon4.jpg', 'default_icon5.jpg', 'default_icon6.jpg', 'default_icon7.jpg']
  end
end
