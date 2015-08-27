require 'rails_helper'

RSpec.shared_examples 'authorized_route' do
  it 'redirects to the sign in page' do
    expect(response).to redirect_to(signin_path)
  end
end
