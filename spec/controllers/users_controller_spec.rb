require 'rails_helper'

RSpec.describe UsersController, type: :controller do
 let(:user_hash) do
    {
      email:    "test@test.email",
      password: "password",
      nickname: "nickname"
    }
  end

  it "Auth" do
    User.create(user_hash)

    post auth_login_path, params: user_hash

    json = JSON.parse(response.body)

    expect(json["token"]).to match(/^[^\"]+$/)
  end
end
