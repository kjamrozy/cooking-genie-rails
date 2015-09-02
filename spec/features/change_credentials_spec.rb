require 'rails_helper'

feature 'change credentials' do
  let(:user) { create(:user) }
  before { page.set_rack_session(user_id: user.id) }
  scenario 'change credentials' do
    visit edit_user_path(user)
    fill_in 'Name', with: 'Madeleine'
    fill_in 'Surname', with: 'Peterson'
    fill_in 'Current password', with: attributes_for(:user)[:password]
    fill_in 'New password', with: '12345678'
    fill_in 'New password confirmation', with: '12345678'
    click_button 'Change'
    user.reload
    expect(user.name).to eq('Madeleine')
    expect(user.surname).to eq('Peterson')
    expect(user.authenticate('12345678')).to be_truthy
  end
end
