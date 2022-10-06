require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { User.new(email: 'test@example.com') }
  let(:hash) { { name: 'Project', description: 'Description', user: user } }
  subject { described_class.new(hash) }

  it 'factory bot creates a valid object' do
    project = create(:project)
    expect(project.name).to eq 'Project 1'
    expect(project.description).to eq 'Description 1'
    expect(project.user.email).to match /user\d+@example.com/
  end

  it 'new does not create a valid object if user is not defined' do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it 'new creates a valid object' do
    expect(subject).to be_valid
    expect(subject.name).to eq hash[:name]
    expect(subject.description).to eq hash[:description]
    expect(subject.user.email).to eq user.email
  end
end
