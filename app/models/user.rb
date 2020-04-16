class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops, dependent: :destroy
  has_many :items, through: :shops

  def has_one_shop?
    self.shops.count == 1
  end

  def has_many_shops?
      self.shops.count > 1
  end

  def has_no_shop?
      self.shops.count == 0
  end 

end
