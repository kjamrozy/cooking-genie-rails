require 'rails_helper'

feature 'stroll through site' do 
  let(:user) { create(:user) }
  before(:each) { page.set_rack_session(user_id: user.id) }
  scenario 'from home to account' do
    visit root_path
    click_link 'Account'
    expect(current_path).to eq(edit_user_path(user))
  end
end