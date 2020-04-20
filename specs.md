# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (shop has_many items)
- [x] Include at least one belongs_to relationship (Shops belong to Users)
- [x] Include at least two has_many through relationships (1. Category has many items, through item_categories, 2. User has many items through shops)
- [x] Include at least one many-to-many relationship (Categories have many items, items have many categories)
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (Shop name)
- [x] Include reasonable validations for simple model objects (user attributes are validated, email needs to have @, password must be at least 6 characters, Shops validate presence of :name, uniqueness: true, can only add items to a shop if they have a name, Category validates presence of name)
- [x] Include a class level ActiveRecord scope method (Category.with_items_alph, Message.between, Item.search)
- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (Facebook)
- [x] Include nested resource show or index (shops/2/items)
- [x] Include nested resource "new" form (shops/2/items/new)
- [x] Include form display of validation errors

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate