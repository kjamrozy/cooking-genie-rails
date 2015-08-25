require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }
  context 'current_user' do
    it 'returns current user instance' do
      session[:user_id] = user.id
      expect(current_user).to eq(user)
    end
  end

  context 'log_in' do
    it 'logs user in' do
      log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  context 'logged_in?' do
    it 'returns true when user is logged in' do
      session[:user_id] = user.id
      expect(logged_in?).to be_truthy
    end

    it "returns false when user isn't logged in" do
      expect(logged_in?).to be_falsy
    end
  end

  context 'log_out' do
    it 'logs user out' do
      expect(session[:user_id]).to be_nil
    end
  end
end
