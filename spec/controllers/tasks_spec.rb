require 'rails_helper'

RSpec.describe TasksController, type: :request do
  let(:project) { create(:project) }
  describe '.index' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should work if signed-in" do
        sign_in create(:user)
        get project_tasks_path(project.id)
        expect(response).to be_successful
      end
    end

    context "when not logged-in" do
      it "should redirect to sign-in" do
        get project_tasks_path(project.id)
        expect(response).to redirect_to(user_session_path)
      end
    end
  end

  describe '.show' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should raise an error when no such task exist" do
        expect do
          get project_task_path(project.id, 1)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should work when task with that id exists" do
        task = create(:task)
        get project_task_path(project.id, task.id)
        expect(response.body).to include("Task #{task.id}")
        expect(response).to be_successful
      end
    end
  end

  describe '.new' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should work when task with that id exists" do
        create(:task)
        get new_project_task_path(project.id)
        expect(response).to be_successful
        expect(response.body).to match "New task"
      end
    end
  end

  describe '.create' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should create a task" do
        expect {
          post project_tasks_path(project.id), params: {
            task: {
              name: 'Name',
              description: 'Description',
              status: 'Done',
            }
          }
        }.to change { Task.count }.by 1
        expect(response.status).to eq 302
      end

      it "should not create a task if email is missing" do
        expect {
          post project_tasks_path(project.id), params: {
            task: {
              name: nil,
              description: 'Description',
            }
          }
        }.not_to change { Task.count }
        expect(response.status).to eq 422
      end
    end
  end

  describe '.update' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should update a task" do
        task = create(:task)
        put project_task_path(project.id, task.id), params: {
          task: {
            name: 'Name',
            description: 'Description'
          }
        }
        task.reload
        expect(response.status).to eq 302
        expect(task.name).to eq 'Name'
        expect(task.description).to eq 'Description'
      end

      it "should not update a task for empty name value" do
        task = create(:task)
        put project_task_path(project.id, task.id), params: {
          task: {
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

      it "should delete a task" do
        task = create(:task)
        expect {
          delete project_task_path(project.id, task.id)
        }.to change { Task.count }.by(-1)
        expect(response.status).to eq 302
      end
    end
  end
end
