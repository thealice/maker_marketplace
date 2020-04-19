class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  validates_presence_of :name
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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  # def can_receive_payments?
  #   uid? &&  provider? && access_code? && publishable_key?
  # end

end
