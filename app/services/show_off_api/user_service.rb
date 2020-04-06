module ShowOffApi
  class UserService < ShowOffApi::BaseService
    def initialize(params={})
      params[:client_id] = ENV["CLIENT_ID"]
      params[:client_secret] = ENV["CLIENT_SECRET"]
      @params = params
    end

    def signup
      ShowOffApi::Visible::RequestService.post_json('api/v1/users', @params)
    end
    
    class << self
      def login(params={})
        ShowOffApi::Visible::RequestService.post_json('oauth/token', params)
      end

      def current_user(token)
        ShowOffApi::Authorized::RequestService.get_current_user('api/v1/users/me', token)
      end
    end
  end
end

# signup action
# params = {"client_id": ENV["CLIENT_ID"], "client_secret": ENV["CLIENT_SECRET"], "user": {"first_name": "James2 Martin","last_name": "Dela2 Cruz","password": "password","email": "rose3@showoff.ie","image_url": "https://static.thenounproject.com/png/961-200.png"}}
# ShowOffApi::UserService.signup(params)

# login action
# params = {"client_id": ENV["CLIENT_ID"], "client_secret": ENV["CLIENT_SECRET"], grant_type: 'password', username: 'james5@test.com', password: 'password'}
# ShowOffApi::UserService.login(params)
