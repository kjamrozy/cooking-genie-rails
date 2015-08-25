require 'rails_helper'

feature 'Sign out' do
  scenario 'signs user out' do
    user = create(:user)
    page.set_rack_session(user_id: user.id)
    visit signout_path
    expect(current_path).to eq(signin_path)
    expect(page.get_rack_session['user_id']).to be_nil
  end
end
