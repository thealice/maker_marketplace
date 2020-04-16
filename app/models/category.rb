class Category < ApplicationRecord
    validates_presence_of :name
    has_many :item_categories
    has_many :items, through: :item_categories

    def self.with_items_alph
        @categories = Category.all.reject do |c|
            c.items.count < 1
        end
        @categories.sort_by {|c| c.name}
    end


end
