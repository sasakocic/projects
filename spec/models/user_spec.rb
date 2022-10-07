require 'rails_helper'

RSpec.describe User, type: :model do
  it 'factory bot creates a valid object' do
    user = create(:user)
    expect(user.email).to match(/user\d+@example.com/)
  end

  it 'factory bot creates unique emails' do
    4.times { create(:user) }
  end

  it 'new does not create a valid object if user is not defined' do
    user = create(:user)
    user.email = nil
    expect(user).not_to be_valid
  end
end
