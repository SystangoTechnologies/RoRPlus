RorPlus
=====================
A Ruby on Rails boilerplate which contains web and api creation environment for quick rails app creation.

# Installation Steps

Step 1 - Install prerequisites
--------------------
  Install Ruby-2.5.1

    rvm install 2.5.1

Step 2 - Clone the Repository
--------------------
    git clone https://github.com/SystangoTechnologies/RorPlus.git ror_plus

Step 3 - Rename it to your Project name
--------------------
  Initially your project name will be ror_plus

    cd ror_plus
    bundle install
    rails g rename:into your_project_name

  a. This will create a project with 'your_project_name'. Open newly created project in editor and check database.yml and .ruby-version for correct database and gemset name
  b. Change directory by cd to newly created project in terminal
  c. Now run 'bundle install'

Step 4 - Setup credentials master key
--------------------
  Create a file in config folder with name 'master.key' and put 'e892b91452fe10406eb557b3d2e663cc' in it

  As this master key is published here so we have to change this to another one.

Step 5 - Setup Api Environment
--------------------
  generate authorization key by running following command

    Base64.strict_encode64("#{Rails.application.credentials.development[:api_client_id]}:#{Rails.application.credentials.development[:api_client_secret]}")

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
  - GlobalConstants configuration
  - Bootstrap v4
