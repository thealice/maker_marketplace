Maker marketplace

Place for the artist community to sell their creations since many have lost sources of income due to COVID. 

like a regular marketplace where trades can be offered

Creators to post items or actions for donation/backer fees. 
example perks include: tie dye shirts, tapes, patches, blank coloring pages, written letter, masks, stationary, prints, cookies, TP, seeds, etc.

Items have a price (defaults to zero). Items can optionally be available for an offer. If item is available for trade, a "make an offer" button is shown. 

homepage is items index. anyone can view items from all shops. Users can "make an offer" if the item is available for trade. make an offer button opens up a mailto:email, or if time a messaging service. 
Can logged out users make an offer or puchase without having an account or do they have to register first? 
All users can buy/trade an item from another user
shop owners can CRUD items in their shop, they can not CRUD other users' items.
Items have many categories and categories have many items. Use a item_categories join table.

- [x] Add "Add new item" to Nav if user only has one shop
- [x] Add "Add Item" to Nav with dropdown for which shop to add to if user has more than one shop
- [x] Add has_one_shop? user method
- [x] Add has_many_shops? user method
- [x] install action_text
- [x] ADD item description as action text
- [x] set make_an_offer default to true
- [x] make default price 0
- [x] allow nested attributes for items in shops model (use the proc so if item name is blank it doesn't save) AND 
- [x] make sure shop has_many :items
- [x] add to permitted shop_params items_attributes: [:id, :name, :description, :price, :quantity ]
- [x] update DB so item category is not a string
- [x] Add Items controller and 
- [x] add nested routes for items within a shop
- [x] make sure shop_id is added (as hidden field?) to items created as nested items.
- [x] make sure shop_id is added to new item resource
- [x] Add category to item form
- [x] Add items_attributes to shop_params
- [x] allow a non-nested route for items index
- [x] update  root_path to items#index
- [x] add a back to shop button or other easy way to see what shop an item belongs to on item show page (maybe breadcrumbs up top?)
- [x] add back button to bottom nav for all pages except homepage
- [x] Create category show page that displays all items in that category
- [x] add categories to nav to get to their show pages
- [x] limit categories in nav bar to those which have items
- [x] make an offer button is mailto link to email of shop open with subject of item name
- [x] add price to item listing (and if trade is option)
- [x] Allow new items to be added directly from shop page

- [] Allow login via Google, Github, Twitter or Instagram
- [] Add meaningful ReadMe.md
- [] Style items listing
- [] Style shops listing (or remove?)
- [] Add My shop button to nav for users with one shop
- [] Add My Shops button to nav for users with more than one shop
- [] Get rid of all unused files like tests/ and devise controllers (controlers/users)
- [] Stretch goal: Make an offer button opens up a conversation between users
  - [] Conversation model
  - [] Conversation migration
  - [] Message model
  - [] Message migration


- [] Stretch goal: Make an offer has an auto-fill for current items the user has to attach to their offer
- [] Stretch goal: shop owners can update items via the shop page
- [] Stretch goal: user sends money directly to Creator via Stripe connect.
- [] Stretch goal: Allow login via Stripe
- [] Stretch goal: Add separate contact info for shop (instead of emailing trade offer to owner of shop)
- [] Stretch goal: look into Friendly ID for slugs:
 https://rubygems.org/gems/friendly_id/versions/5.1.0
- [] Stretch goal: install stimulus js so new items form on shop page only pops up if you click on a button
bundle exec rails webpacker:install:stimulus
- [] Stretch goal: users can search items from all shops. 
- [] Stretch goal: users can post comments (on items or shops)

https://learn.co/tracks/online-software-engineering-uci-structured/rails/rails-project-mode/rails-portfolio-project

Your models must:

   - [x] Include at least one has_many (shop has_many items), at least one belongs_to (item belongs to shop), and at least two has_many :through relationships (1. Category has many items, through item_categories, 2. User has many items through shops)

   - [x] Include a many-to-many relationship implemented with has_many :through associations. The join table must include a user-submittable attribute — that is to say, some attribute other than its foreign keys that can be submitted by the app's user (Shops)
    
   - [x] Include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data. (user attributes are validated, email needs to have @, password must be at least 6 characters, Shops validate presence of :name, uniqueness: true, can only add items to a shop if they have a name, Category validates presence of name)

   - [x] Include at least one class level ActiveRecord scope method. a. Your scope method must be chainable, meaning that you must use ActiveRecord Query methods within it (such as .where and .order) rather than native ruby methods (such as #find_all or #sort).
   Category.with_items_alph

Your application must:

   - [x] provide standard user authentication, including signup, login, logout, and passwords.

   - [] allow login from some other service. Facebook, Twitter, Foursquare, Github, etc...

   - [x] make use of a nested resource with the appropriate RESTful URLs.

   - [x] include a nested new route with form that relates to the parent resource (shops/1/items/new)

   - [x] include a nested index or show route (shops/1/items/4)

Your forms should correctly display validation errors.

    - [x] Your fields should be enclosed within a fields_with_errors class

    - [x] Error messages describing the validation failures must be present within the view.

Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app.

   - [] Logic present in your controllers should be encapsulated as methods in your models.

   - [] Your views should use helper methods and partials when appropriate.

   - [] Follow patterns in the Rails Style Guide and the Ruby Style Guide.


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
?cash_app_name:string?
?cash_app_username:string?
User_id foreign key

rails g resource Shop name:string status:string user:references

then install action text to store description

rails action_text:install
check migrations and rails db:migrate
  has_rich_text :description
  has_one_attached :thumbnail

has_many :items
belongs_to :user

ITEM Attributes (Relative to Shops but seperated (nested attributes?): CHANGE ITEM to PRODUCT??
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

CATEGORY
  name:string

  has_many :item_categories
  has_many :items, through: item_categories

ITEM_CATEGORY
  belongs_to :item
  belongs_to :category

------------------------------

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



Sidekiq is for background jobs and mailers, i don't think this is necessary for now
mailcatcher is for mailer, skip this for now

- [x]Bootstap menu not loading in small widths.
get error: DevTools failed to parse SourceMap
check https://blog.sentry.io/2018/10/18/4-reasons-why-your-source-maps-are-broken


--------------------------------------------------