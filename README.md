# Overview

We have exposed an API for the purposes of this technical test which encapsulates Widgets which belong to
Users. Access to the API is granted through a standard OAuth2 process.
Please implement, per the details below, your own Rails application which wraps our API and allows Users to
manage and view Widgets.
Widgets can either be hidden, in which case they are only visible to the User who created them, or visible, in which
case they are visible to all Users. Users can only manage their own Widgets, whether they are public or private.

Please Note: There may be other people using the same API at the same time as you, so please limit the amount
of personal information you provide when creating Users and Widgets.

# Widget API

Please see https://documenter.getpostman.com/view/263900/RztoL8FR for details of the API and its actions.
This provides illustrative examples of each of the endpoints, as well as the Client ID and Client Secret you will
need in order to interact with the API.
The Widget API we have exposed offers the following endpoints, as follows:

* Authentication - Standard OAuth
  * Create Access Token
  * Revoke Access Token
  * Refresh Access Token

* Users - User Management
  * Widgets - User Widget Management
    * List (Own)
    * List (Own) with a Search Term
    * List (User ID)
    * List (User ID) with a Search Term
  * Create User
  * Update User
  * Show (Logged In User)
  * Show (User ID)
  * Change Password
  * Check Email
  * Reset Password
* Widgets
  * Visible (Public)
    * List
    * List with search term
  * Create Widget (Hidden)
  * Create Widget (Visible)
  * Update Widget
  * Destroy Widget
  * List Widgets (Own)

# Technical Test
## Ruby on Rails Application

Please build a Ruby on Rails application which fulfils the following requirements:
* ~Rails 4, 5, or 6~
* Include an API Client for the widget
* General:
  * Use any Gems/techniques you find useful.
  * We would recommend using the rest-client Gem for building your API client, but feel free to use any
other library that you have experience with.
  * Include a thorough Readme describing how to build/run your application.
* Functionality
  * Allows Users to interact with the widgets API defined as above, through which it allows them to use
all actions of the Widget API:
    * Authentication
    * User Management
    * Widget Views & Search
* Structure
  * Landing Page should present a list of Visible Widgets
    * This should be searchable, using the API.
  * Allow Users to Login/Logout/Register/Reset Password via Modal.
  * On the landing page, each item in the list of Widgets should include a reference to the User that
created it.
  * Once logged in the User should be able to navigate to a view of their Widgets.
    * They should also be able to create a new widget from this view.
* Bonus Round:
  * Deployed to Heroku.
  * Full Test Suite (Minitest or RSpec).
  * Setup the build process so that it will allow for different sets of environment variables depending on
the environment it is being deployed to.

## General
* Please use Git to track your progress through the above tasks.
  * Make regular commits, with descriptive commit messages.
* Please return one of the following:
  * Links to your source code and documentation on Github/Bitbucket.
  * A Zip containing all of your source code and documentation.

# Best of luck
## OSU!
