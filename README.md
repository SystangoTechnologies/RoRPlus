RorPlus
=====================
A Ruby on Rails boilerplate which contains web and api creation environment for quick rails app creation.

# Installation Steps

Step 1 - Clone the Repository
--------------------
    git clone https://github.com/SystangoTechnologies/RorPlus.git

Step 2 - Rename it to your Project name
--------------------
    rails g rename:into your_project_name
    after running this command please check database.yml and .ruby-version for correct database and gemset name
    run bundle install

Step 3 - Setup Api Environment
--------------------
  generate authorization key by running following command

    Base64.strict_encode64("#{Rails.application.credentials.development[:api_client_id]}:#{Rails.application.credentials.development[:api_client_secret]}")

  You have to pass this Authorization key in every api call.

  User's login, signup and logout apis are already there. You can customize the fields as per your requirements.

  In this Api environment we have used JWT authenication.


This boilerplate consist following things configured in it
--------------------
  - Latter Opener: All your emails in development environment will get displayed in your browser instead of actually delivered to the email. This way you can check that all emails are getting sent properly.
  - HAML for html templates integration
  - Devise for users authentication
  - API environment setup with Grape and Swagger to create APIs
  - JWT authentication for APIs
  - Swagger for listing Api Doc and provides UI to call apis from there itself
  - GlobalConstants configuration
