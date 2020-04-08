RSpec.shared_context "generate_token", :vcr do
  before do
    params = {
      username: "totoy101@yahoo.com",
      password: "password"
    }
    @token = ShowOffApi::AuthenticateService.login(params).token['access_token']
  end
end
