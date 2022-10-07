require 'rails_helper'

RSpec.describe Member, type: :model do
  it 'factory bot creates a valid object' do
    member = create(:member)
    member1 = create(:member)
    member2 = create(:member)
    expect(member.name).to match 'Member'
    expect(member.description).to match 'Description'
    expect(member.user.email).to match(/user\d+@example.com/)
  end

  it 'new does not create a valid object if user is not defined' do
    member = create(:member)
    member.user = nil
    expect(member).not_to be_valid
  end
end
