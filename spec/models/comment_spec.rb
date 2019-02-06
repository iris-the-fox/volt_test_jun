require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Association test
  it { should belong_to(:post) }
  it { should belong_to(:author) }
  # Validation tests
  it { should validate_presence_of(:body) }

end
