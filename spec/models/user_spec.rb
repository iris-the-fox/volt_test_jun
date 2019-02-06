require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:posts).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }


end
