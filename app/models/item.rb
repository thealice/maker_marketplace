class Item < ApplicationRecord
  belongs_to :shop
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  has_rich_text :description
  has_one_attached :thumbnail, dependent: :destroy
end
