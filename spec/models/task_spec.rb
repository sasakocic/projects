require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'factory bot creates a valid object' do
    task = create(:task)
    expect(task).to be_valid
    expect(task.name).to match 'Task'
    expect(task.description).to match 'Description'
    expect(task.project.name).to match(/Project \d+/)
    expect(task.member.name).to match(/Member \d+/)
    expect(task.status).to match 'Done'
  end

  it 'is not a valid object if project is not defined' do
    task = create(:task)
    task.project = nil
    expect(task).not_to be_valid
  end

  it 'is a valid object even if member (assignee) is not defined' do
    task = create(:task)
    task.member = nil
    expect(task).not_to be_valid
  end
end
