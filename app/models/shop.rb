class Shop < ApplicationRecord
  validates_presence_of :name, uniqueness: true
  belongs_to :user

  has_rich_text :description
  has_one_attached :featured_image, dependent: :destroy

end
