# Maker Marketplace

Maker Marketplace is an online marketplace that allows individuals to sell or trade items they have made. All logged in users can create, edit and delete their own shops. They can list items for sale or trade in their shops. All users (whether logged in or out) can browse and search items for sale or trade. They can message a shop owner to inquire about a purchase or trade (they will be prompted to login or signup to do this if they aren't yet). 

Logged-in users can access all of their messages with various other users. Messaging conversations, once started, are continuous (there is only one conversation between the same two users no matter who is sender or recipient). Users can sign in or create an account via Facebook, or the regular login/signup form. The app uses Devise for user authentication managing user profiles and some of the validations.

See https://youtu.be/S3jc_UV_tO4 for a brief runthrough.

My blogpost on how to create your own Rails app can be found at https://thealice.github.io/getting_started_on_your_rails_app_a_step-by-step_guide

## Getting Started

To get Maker Marketplace running on your local machine for development and testing purposes, fork and clone this repo:

 ```
  git clone git@github.com:thealice/maker_marketplace.git

```
 After cloning the repo, install all the required gems with `bundle install`.
 Then run `rails db:migrate`.
 You can run it locally with `rails server`.

## Built With

* [Rails](https://rubyonrails.org/) - Web Framework
* [Bundler](https://bundler.io/) - Dependency Management
* [Postgres](https://www.postgresql.org/) - Database
* [Bootstrap](https://getbootstrap.com/) - Front-end component library
* [Devise](https://github.com/heartcombo/devise) - User authentication
* [Action Text](https://github.com/rails/rails/tree/v6.0.0.rc1/actiontext) - Rich text content editing and image attachments

## Contributing

* Please read and follow our [Code of Conduct](CODE-OF-CONDUCT.md).
* Bug reports and pull requests are very welcome on GitHub at https://github.com/[thealice]/maker_marketplace. 

## Authors

[thealice](https://github.com/thealice)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

Thanks to: 
* [Allison Cortez](https://github.com/allisoncortez) for moral support
* My instructor, [Madeline Stark](https://github.com/Madeline-Stark)
* and [Web-Crunch Tutorials](https://web-crunch.com) for instructions on the messaging portion.
