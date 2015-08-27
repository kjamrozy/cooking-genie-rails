require 'rails_helper'

feature 'Sign up' do
  scenario 'creates new user' do
    visit signup_path
    expect do
      fill_in 'Name', with: 'John'
      fill_in 'Surname', with: 'Smith'
      fill_in 'Email', with: 'simple@mailworld.com'
      fill_in 'Password', with: 'secret_password'
      fill_in 'Password confirmation', with: 'secret_password'
      click_button 'Create an account'
    end.to change { User.count }.by(1)
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Account was successfully created!')
  end

  scenario 'fails to create new user' do
    create(:user, email: 'same@thesame.com')
    visit signup_path
    expect do
      fill_in 'Name', with: ''
      fill_in 'Surname', with: ''
      fill_in 'Email', with: 'same@thesame.com'
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: '1234'
      click_button 'Create an account'
    end.not_to change { User.count }
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Surname can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content('Email has already been taken')
    expect(page)
      .to have_content('Password is too short (minimum is 8 characters)')
    expect(page).not_to have_content('Account was successfully created!')
  end
  scenario 'going from sign up to sign in page' do
    visit signup_path
    click_link 'Sign in!'
    expect(current_path).to eq(signin_path)
  end
end
