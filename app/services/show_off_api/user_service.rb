module ShowOffApi
  class UserService < ShowOffApi::BaseService
    class << self
      # Create user
      def signup(params={})
        ShowOffApi::Visible::RequestService.post_json('users', params)
      end
    end
  end
end

# params = {"client_id": ENV["CLIENT_ID"], "client_secret": ENV["CLIENT_SECRET"], "user": {"first_name": "James2 Martin","last_name": "Dela2 Cruz","password": "password","email": "rose3@showoff.ie","image_url": "https://static.thenounproject.com/png/961-200.png"}}
# ShowOffApi::UserService.signup(params)
