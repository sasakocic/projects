require 'rails_helper'

RSpec.describe MembersController, type: :request do
  describe '.index' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should work if signed-in" do
        sign_in create(:user)
        get members_path
        expect(response).to be_successful
      end
    end

    context "when not logged-in" do
      it "should redirect to sign-in" do
        get members_path
        expect(response).to redirect_to(user_session_path)
      end
    end
  end

  describe '.show' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should raise an error when no such member exist" do
        expect do
          get member_path(1)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should work when member with that id exists" do
        create(:member)
        get member_path(1)
        expect(response.body).to include("member1@example.com")
        expect(response).to be_successful
      end
    end
  end

  describe '.new' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should work when member with that id exists" do
        create(:member)
        get new_member_path
        expect(response).to be_successful
        expect(response.body).to match "New member"
      end
    end
  end

  describe '.create' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should create a member" do
        expect {
          post members_path, params: {
            member: {
              name: 'Name',
              email: 'name@example.com',
              description: 'Description',
            }
          }
        }.to change { Member.count }.by 1
        expect(response.status).to eq 302
      end

      it "should not create a member if email is missing" do
        expect {
          post members_path, params: {
            member: {
              name: 'Name',
              description: 'Description',
            }
          }
        }.not_to change { Member.count }
        expect(response.status).to eq 422
      end
    end
  end

  describe '.update' do
    context "when logged-in" do
      before do
        sign_in create(:user)
      end

      it "should update a member" do
        member = create(:member)
        put member_path(member.id), params: {
          member: {
            name: 'Name',
            email: 'name@example.com',
            description: 'Description'
          }
        }
        member.reload
        expect(response.status).to eq 302
        expect(member.name).to eq 'Name'
        expect(member.email).to eq 'name@example.com'
        expect(member.description).to eq 'Description'
      end

      it "should not update a member for empty email value" do
        member = create(:member)
        put member_path(member.id), params: {
          member: {
            name: 'Name',
            email: nil,
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

      it "should delete a member" do
        create(:member)
        expect {
          delete member_path(Member.last.id)
        }.to change { Member.count }.by(-1)
        expect(response.status).to eq 302
      end
    end
  end
end
