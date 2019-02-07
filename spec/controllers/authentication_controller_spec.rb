require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user_hash) do
    {
      email:    "test@test.email",
      password: "password",
      nickname: "nickname"
    }
  end

  it "Auth" do
    User.create(user_hash)

    post auth_login_path, params: {email: user_hash[:email], password: user_hash[:password]}

    json = JSON.parse(response.body)

    expect(json["token"]).to match(/^[^\"]+$/)
  end
end
