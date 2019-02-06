require 'rails_helper'

RSpec.describe Post, type: :model do
  # Association test
  it { should have_many(:comments).dependent(:destroy) }
  it { should belong_to(:author) }
  # Validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

end
