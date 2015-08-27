require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  include SessionsHelper
  before(:each) do
    user = create(:user)
    log_in(user)
  end
  context 'GET #home' do
    before(:each) { get :home }
    it_behaves_like 'accessible_route', :home, 'application'
  end

  context 'GET #about' do
    before(:each) { get :about }
    it_behaves_like 'accessible_route', :about, 'application'
  end
end
