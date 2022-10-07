require 'rails_helper'

RSpec.describe "GET /members", type: :request do
  context "when logged-in" do
    before do
      sign_in create(:user)
    end

    it "/1 should raise an error when no such member exist" do
      expect do
        get member_path(1)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "/1 should work when member with that id exists" do
      sign_in create(:user)
      create(:member)
      get member_path(1)
      expect(response.body).to include("member1@example.com")
      expect(response).to be_successful
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
