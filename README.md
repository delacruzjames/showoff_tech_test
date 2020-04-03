## Overview

We have exposed an API for the purposes of this technical test which encapsulates Widgets which belong to
Users. Access to the API is granted through a standard OAuth2 process.
Please implement, per the details below, your own Rails application which wraps our API and allows Users to
manage and view Widgets.
Widgets can either be hidden, in which case they are only visible to the User who created them, or visible, in which
case they are visible to all Users. Users can only manage their own Widgets, whether they are public or private.

Please Note: There may be other people using the same API at the same time as you, so please limit the amount
of personal information you provide when creating Users and Widgets.

## Widget API

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
  
