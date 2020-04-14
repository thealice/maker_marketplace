class Shop < ApplicationRecord
  validates_presence_of :name, uniqueness: true
  belongs_to :user
  has_many :items, dependent: :destroy

  has_rich_text :description
  has_one_attached :featured_image, dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |attr| attr['name'].blank? }

end
