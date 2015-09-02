require 'rails_helper'

RSpec.shared_examples 'sets active' do |page|
  it "sets active class on #{page}" do
    user = stub(attributes_for(:user, admin: true))
    assign(:current_user, user)
    flash.now[:active] = page
    render
    expect(rendered).to have_selector("li##{page}.active")
  end
end

describe 'layouts/application.haml' do
  include_examples 'sets active', 'home'
  include_examples 'sets active', 'products'
  include_examples 'sets active', 'manage'
  include_examples 'sets active', 'account'
  include_examples 'sets active', 'about'
end
