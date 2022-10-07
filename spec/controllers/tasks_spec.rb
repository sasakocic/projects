require 'rails_helper'

RSpec.describe "GET /project/1/tasks", type: :request do
  context "when logged-in" do
    before do
      sign_in create(:user)
    end

    it "/1 should raise an error when no such task exist" do
      expect do
        get project_task_path(1, 1)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "/1 should work when task with that id exists" do
      sign_in create(:user)
      task = create(:task)
      get project_task_path(task.project.id, task.id)
      expect(response.body).to include("Task 1")
      expect(response).to be_successful
    end

    it "should work if signed-in" do
      sign_in create(:user)
      project = create(:project)
      get project_tasks_path(project.id)
      expect(response).to be_successful
    end
  end

  context "when not logged-in" do
    it "should redirect to sign-in" do
      project = create(:project)
      get project_tasks_path(project.id)
      expect(response).to redirect_to(user_session_path)
    end
  end
end
