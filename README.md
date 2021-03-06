![Logo of RoRPlus](https://drive.google.com/uc?id=1HAGX3lPk2W46XrMcg0vpdUB5ejmpa-bC)

RorPlus
=====================

A Ruby on Rails boilerplate which contains web and api creation environment for quick rails app creation.

# Installation Steps

Step 1 - Install prerequisites
--------------------
  Install Ruby-2.6.3

    rvm install 2.6.3

Step 2 - Clone the Repository
--------------------
    git clone https://github.com/SystangoTechnologies/RorPlus.git ror_plus

Step 3 - Setup credentials master key
--------------------
  Open this project and create a file in config folder with name 'master.key' and put 'e892b91452fe10406eb557b3d2e663cc' in it

  As this master key is published here so we have to change this to another one. To do that we will create new rails application by running

    rails new testing_app
    cd testing_app
    EDITOR="vi" bin/rails credentials:edit

  Paste following credentials to it:

    development:
      base_url: 'http://localhost:3000'
      api_client_id: 'ror_plus'
      api_client_secret: 'HDFkfRorPlus645'
      api_hmac_secret: 'HfgisL637'

  Save the changes.

  Now you have another master.key and encrypted credentials in this testing_app repository. Copy them from this project and paste in our ror_plus project and Done.

Step 4 - Rename it to your Project name
--------------------
  Initially your project name will be ror_plus

    cd ror_plus
    bundle install
    rails g rename:into your_project_name

  a. This will create a project with 'your_project_name'. Open newly created project in editor and check database.yml and .ruby-version for correct database and gemset name

  b. Change directory by cd to newly created project in terminal

  c. Now run

    gem install bundler
    bundle install

Step 5 - Setup Api Environment
--------------------
  generate authorization key by running following command in rails console

    Base64.strict_encode64("#{$secret[:api_client_id]}:#{$secret[:api_client_secret]}")

  You have to pass this Authorization key in every api call.

  User's login, signup and logout apis are already there. You can customize the fields as per your requirements.

  In this Api environment we have used JWT authenication.


This boilerplate consist following things configured in it
--------------------
  - Letter Opener: All your emails in development environment will get displayed in your browser instead of actually delivered to the email. This way you can check that all emails are getting sent properly.
  - HAML for html templates integration
  - Devise for users authentication
  - API environment setup with Grape and Swagger to create APIs
  - JWT authentication for APIs
  - Swagger for listing Api Doc and provides UI to call apis from there itself
  - Constants configuration
  - Bootstrap v4

## Contributors

  Pradeep Agrawal

## License

  This project is released under the [MIT License](https://opensource.org/licenses/MIT).
