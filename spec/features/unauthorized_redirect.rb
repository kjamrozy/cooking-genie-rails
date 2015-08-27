require 'rails_helper'

feature 'unauthorized redirect' do
  scenario 'unauthorized access to the route' do
    visit home_path
    expect(page).to have_content('Firstly you should sign in!')
  end
end
