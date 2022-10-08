require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
  describe '.index' do
    context "when logged-in" do
      before do
        sign_in create(:user)
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

  describe '.show' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should raise an error when no such project exist" do
        expect do
          get project_path(1)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should work when project with that id exists" do
        project = create(:project)
        get project_path(project.id)
        expect(response.body).to include("Project 1")
        expect(response).to be_successful
      end
    end
  end

  describe '.new' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should work when project with that id exists" do
        create(:project)
        get new_project_path
        expect(response).to be_successful
        expect(response.body).to match "New project"
      end
    end
  end

  describe '.create' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should create a project" do
        expect {
          post projects_path, params: {
            project: {
              name: 'Name',
              description: 'Description',
            }
          }
        }.to change { Project.count }.by 1
        expect(response.status).to eq 302
      end

      it "should not create a project if email is missing" do
        expect {
          post projects_path, params: {
            project: {
              description: 'Description',
            }
          }
        }.not_to change { Project.count }
        expect(response.status).to eq 422
      end
    end
  end

  describe '.update' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should update a project" do
        project = create(:project)
        put project_path(project.id), params: {
          project: {
            name: 'Name',
            description: 'Description'
          }
        }
        project.reload
        expect(response.status).to eq 302
        expect(project.name).to eq 'Name'
        expect(project.description).to eq 'Description'
      end

      it "should not update a project for empty name value" do
        project = create(:project)
        put project_path(project.id), params: {
          project: {
            name: nil,
            description: 'Description'
          }
        }
        expect(response.status).to eq 422
      end
    end
  end

  describe '.delete' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should delete a project" do
        create(:project)
        expect {
          delete project_path(Project.last.id)
        }.to change { Project.count }.by(-1)
        expect(response.status).to eq 302
      end
    end
  end
end
