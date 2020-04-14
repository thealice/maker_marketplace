Artist support marketplace

Place for the artist community to sell their creations since many have lost sources of income due to COVID. ?Users can support their favorite artists by subscribing to content/perks like patreon.?
Or is this more like a regular marketplace where trades can be offered?

Creators to post items or actions for donation/backer fees. 
example perks include: tie dye shirts, tapes, patches, blank coloring pages, written letter, masks, stationary, prints, cookies, TP, seeds, etc.

Items have a price (defaults to zero). Items can optionally be available for an offer. If item is available for trade, a "make an offer" button is shown. 

homepage is items index. anyone can view items from all shops. Users can "make an offer" if the item is available for trade. make an offer button opens up a mailto:email, or if time a messaging service. 
Can logged out users make an offer or puchase without having an account or do they have to register first? 
All users can buy/trade an item from another user
shop owners can CRUD items in their shop, they can not CRUD other users' items.
Items have many categories and categories have many items. Use a item_categories join table.


Stretch goal: user sends money directly to Creator via Stripe connect.
Stretch goal: shop owners can update items via the shop page
Stretch goal: users can search items from all shops. 
Stretch goal: make an offer opens up a messaging conversation
Stretch goal: Add trade function so users can make an offer via messaging functionality
Stretch goal: users can post comments 
Stretch goal: members of the community can write testimonials on other people's shop "walls" as Comments

https://learn.co/tracks/online-software-engineering-uci-structured/rails/rails-project-mode/rails-portfolio-project

Your models must:

    • Include at least one has_many, at least one belongs_to, and at least two has_many :through relationships

    • Include a many-to-many relationship implemented with has_many :through associations. The join table must include a user-submittable attribute — that is to say, some attribute other than its foreign keys that can be submitted by the app's user
    
    • Include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data.

    • Include at least one class level ActiveRecord scope method. a. Your scope method must be chainable, meaning that you must use ActiveRecord Query methods within it (such as .where and .order) rather than native ruby methods (such as #find_all or #sort).

Your application must:

    • provide standard user authentication, including signup, login, logout, and passwords.

    • allow login from some other service. Facebook, Twitter, Foursquare, Github, etc...

    • make use of a nested resource with the appropriate RESTful URLs.

    • include a nested new route with form that relates to the parent resource (shops/1/items/new)

    • include a nested index or show route (shops/1/items/4)

Your forms should correctly display validation errors.

    a. Your fields should be enclosed within a fields_with_errors class

    b. Error messages describing the validation failures must be present within the view.

Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app.

    • Logic present in your controllers should be encapsulated as methods in your models.

    • Your views should use helper methods and partials when appropriate.

    • Follow patterns in the Rails Style Guide and the Ruby Style Guide.


models: User (with three roles?: Admin, maker, buyer), Shop, Item, CAtegory, ItemCategory, Comment?, Order??, Trade?
SEE: https://github.com/heartcombo/devise/wiki/How-To:-Add-an-Admin-Role for info on Roles

root to: 'items#index'

Devise helper methods:
user_signed_in?
current_user
user_session
destroy_user_session_path (Logout)
new_user_session_path (Login)
edit_user_registration_path (Edit registration)
new_user_registration_path (Register new user)

User Model. Roles: Admin, Creator, Customer ???
Try using devise: https://guides.railsgirls.com/devise
gem 'devise'
bundle install
rails g devise:install
set configurations
rails g devise model User 

you can generate controllers with this command but will also have to edit the routes.rb file if you want to override the defaults
rails generate devise:controllers users
https://github.com/heartcombo/devise/wiki/Tool:-Generate-and-customize-controllers

rails generate devise:views users

USER Attributes:

Username
Name
Email
Password
admin:boolean

has_many :shops, dependent: :destroy
has_many :items, through: shops

?has_many :conversations?
?has_many :messages, through: conversations?

See https://stackoverflow.com/questions/17000497/rails-devise-custom-registration-and-login-at-the-same-page-issues for customizing forms

SHOP Attributes:
name:string
description:text
status:string
cash_app_name:string
cash_app_username:string
User_id foreign key

rails g resource Shop name:string status:string user:references

then install action text to store description

rails action_text:install
check migrations and rails db:migrate
  has_rich_text :description
  has_one_attached :thumbnail

has_many :items
belongs_to :user

shop owners can update items via the shop page: 
accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |attr| attr['title'].blank? }



ITEM Attributes (Relative to Shops but seperated (nested attributes?): 
name:string
description:text
price:decimal
make_an_offer:boolean, default true
quantity:integer
shop_id:integer foreign key

has_many :item_categories, dependent: :destroy
has_many :categories, through: :item_categories
belongs_to :shop

rails g model Item name:string price:decimal category:string quantity:integer make_an_offer:boolean shop:references

ADD description as action text?

set make_an_offer default to true
make default price 0

allow nested attributes for items in shops model (use the proc so if item name is blank it doesn't save) AND make sure shop has_many :items

add to permitted shop_params items_attributes: [:id, :name, :description, :price, :quantity ]

install stimulus js?
bundle exec rails webpacker:install:stimulus


CONVERSATION 
sender_id:integer
recipient_id:integer


class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  has_many :messages

  validates_uniqueness_of :sender_id, scope: :recipient_id

  # This scope validation takes the sender_id and recipient_id for the conversation and checks whether a conversation exists between the two ids because we only want two users to have one conversation.

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
  end
end


MESSAGE
body:text
conversation_id:integer foreign key
user_id:integer foreign key

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end

 Comment (polymorphic)
rails g model Comment commentable_type:string commentable_id:integer user:references body:text
rails g controller comments create
rails g controller projects/comments

Body



GEMS:

Devise
Pry
Bootstrap

look into Friendly ID for slugs:
 https://rubygems.org/gems/friendly_id/versions/5.1.0

install action_text

Sidekiq is for background jobs and mailers, i don't think this is necessary for now
mailcatcher is for mailer, skip this for now

Bootstap menu not loading in small widths.
get error: DevTools failed to parse SourceMap
check https://blog.sentry.io/2018/10/18/4-reasons-why-your-source-maps-are-broken

make sure to get ride of all unused files like tests/ and devise controllers (controlers/users)
--------------------------------------------------


Maker marketplace/carepackages - place for makers to post items or actions for sale/trade/free/shipping fee only 
example items include: tie dye shirts, tapes, patches, blank coloring pages, written letter, masks, stationary, prints, cookies, TP, seeds, etc.

All users can CRUD items they are offering, they can not CRUD other users' items.
All users can buy/trade an item from another user
Users who are shop owners can view all orders they have received
STRETCH?buyers can view all orders they have made?
Items can be added to an order. 
Items have a price but a buyer can also suggest a trade for it by showing the seller which item they would trade for it with.
How does the order know which user is the buyer and which is the seller? If the Order has a shop_id and a Buyer is User? Or maybe, upon signup, user selects whether they would like to be a seller and if so, they are automatically assigned a seller_id?


MVP: checkout one item at a time, no payment processor, payments are handled via venmo, cashapp, zelle, cash, whatever the maker's preference.

Stretch goal: Site sends money directly to maker via Stripe Connect
Stretch goal: can add multiple items per order
Stretch? goal: User has multiple items in a CART which will go to different makers upon checkout. Or start with one item at a time?

models: User (All users can buy and sell), Shop, Item, Category, ItemCategory, Order, Transaction?

Item
has_many :item_categories, dependent: :destroy
has_many :categories, through: :item_categories

has_many :orders
has_many :users, through: :orders
belongs_to :shop

item.users = those who have purchased that item

attrs:
name:string
description:text
price:decimal
image_src:string
shop_id:integer

Category
has_many :item_categories
has_many :items, through: :item_categories

attrs:
name:string

ItemCategory
belongs_to :item
belongs_to :category

attrs:
item_id
category_id

User
rails generate devise User

has_many :orders
has_many :items, through: :orders
has_one :shop

user.items will display items purchased by this user
user.shop.items will display items in the user's shop

list of categories in a user's shop:
<ul>
	user.shop.items each do |item|
		item.item_categories.each do |category|
			<li>category</li> if that category hasn't already been printed out
		end
	end
</ul>

Shop
belongs_to :seller, ??class_name: 'User'??
has_many :items
has_many :item_categories, through: items
has_many :orders

shop.user = shop owner
shop.items = items added by shop owner
shop.items.each do |item|
	item.users = those who have purchased this item from the shop
end

attrs:
description:text
user_id:integer

Order
belongs_to :shop
has_many   :order_items, :dependent => :destroy
belongs_to ??:buyer, class_name: 'User'??
belongs_to ??:seller, class_name: 'User'??

attrs:
item_id:integer
????
seller_id:integer
buyer_id:integer
user_id:integer
????
quantity:integer
note:text
paid:boolean
shipped:boolean default(FALSE), not null
active:boolean default(TRUE), not null
ship_address

Maker marketplace/carepackages - place for makers to post items or actions for sale/trade/free/shipping fee only 
example items include: tie dye shirts, tapes, patches, blank coloring pages, written letter, masks, stationary, prints, cookies, TP, seeds, etc.

Items have a price (defaults to zero)

MVP: checkout one item at a time, no payment processor, payments are handled via venmo, cashapp, zelle, cash, whatever the maker's preference.

Stretch goal: Site sends money directly to maker via Stripe Connect
Stretch? goal: User has multiple items in a CART which will go to different makers upon checkout. Or start with one item at a time?

models: User (with three roles: Admin, maker, buyer), Store(Project), Item(Perk), Comment, Order??, CART???
SEE: https://github.com/heartcombo/devise/wiki/How-To:-Add-an-Admin-Role for info on Roles

root to: 'items#index'

User Attributes:
Roles: Admin, Maker, Backer
Username
Name
Email
Password
?cashapp link?
?venmo link?
?social link(IG, website, etc)?

Store(Project) Attributes:
Name(Title)
Description
Website
Commentable Type
Commentable ID
User ID

Item Attributes (Relative to Stores but seperated (nested attributes?): 
Name(Title)
Description
Amount
Amount Available
Category
Store ID(Project ID)



Comment
Body




or 

Maker
has_many items
email

makers/1/items

Item
belongs_to :maker
has_may :trades
has_many buyers, through: :trades
Price
open_to_trade?
number_available

Trade/Sale receipt/Order
belongs_to item
belongs_to buyer
monetary value?/trade?
quantity_of_items?
item_received in return
quantity of items received?


Buyer
has_many :trades
has_many :trades, though: :buyers




OR one simple ecommerce store where a user can browse items while logged out but must be logged in to checkout. Admin is the only one who can add products and categories

models: Product, Category, ProductCategories, User, Admin, Order (Cart is not a model but gets a controller and a view possibly)
see: https://github.com/heartcombo/devise/wiki/How-To:-Add-an-Admin-Role for Admin role

Product
has_many :product_categories, dependent: :destroy
has_many :categories, through: :product_categories

has_many :orders
has_many :users, through: :orders

attrs:
name:string
description:text
price:decimal
image_src:string

Category
has_many :product_categories
has_many :products, through: :product_categories

attrs:
name:string

ProductCategory
belongs_to :product
belongs_to :category

attrs:
product_id
category_id

User
rails generate devise User

has_many :orders
has_many :products, through: :orders

Admin
rails generate devise Admin

Admin uses nested routes
/admin/categories
/admin/products

controllers/admin/products
controllers/admin/categories

Order
belongs_to :product
belongs_to :user

attrs:
product_id:integer
user_id:integer
quantity:integer
note:text
paid:boolean
shipped:boolean default(FALSE), not null
active:boolean default(TRUE), not null
ship_address

carts_controller
class Admin::OrdersController < ApplicationController

class TransactionsController
before_action :authenticate_user!
before_action :check_cart!







