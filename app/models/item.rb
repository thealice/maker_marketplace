class Item < ApplicationRecord
  belongs_to :shop
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  has_rich_text :description
  has_one_attached :thumbnail, dependent: :destroy

  validates_presence_of :name

  def self.search(query)
    if query.blank?
      self.all
    else
      where('NAME ilike ?', "%#{query}%") #ilike makes query case insensitive in postgres
    end
  end

  def self.by_most_recent
    Item.all.sort_by{|item| item.created_at}.reverse
  end

end
