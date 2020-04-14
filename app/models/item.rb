class Item < ApplicationRecord
  belongs_to :shop

  has_rich_text :description
  has_one_attached :thumbnail, dependent: :destroy
end
