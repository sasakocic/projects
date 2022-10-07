require 'rails_helper'

RSpec.describe "GET /projects", type: :request do
  context "when logged-in" do
    before do
      sign_in create(:user)
    end

    it "/1 should raise an error when no such project exist" do
      expect do
        get project_path(1)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "/1 should work when project with that id exists" do
      sign_in create(:user)
      project = create(:project)
      get project_path(project.id)
      expect(response.body).to include("Project 1")
      expect(response).to be_successful
    end

    it "should work if signed-in" do
      sign_in create(:user)
      get projects_path
      expect(response).to be_successful
    end
  end

  context "when not logged-in" do
    it "should redirect to sign-in" do
      get projects_path
      expect(response).to redirect_to(user_session_path)
    end
  end
end
