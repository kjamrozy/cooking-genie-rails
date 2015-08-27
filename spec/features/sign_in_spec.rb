require 'rails_helper'

feature 'Sign in' do
  include SessionsHelper
  scenario 'signs in' do
    user = create(:user)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: attributes_for(:user)[:password]
    click_button 'Sign in'
    expect(current_path).to eq(root_path)
    expect(page.get_rack_session['user_id']).to eq(user.id)
  end

  scenario 'fails to sign in' do
    visit signin_path
    fill_in 'Email', with: 'invalid@gmail.com'
    fill_in 'Password', with: '1234'
    click_button 'Sign in'
    expect(page).to have_content('Invalid email/password')
  end

  scenario 'going from sign in to sign up page' do
    visit signin_path
    click_link 'Create an account!'
    expect(current_path).to eq(signup_path)
  end
end
