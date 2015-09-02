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
    it 'sets active to home' do
      expect(flash[:active]).to eq('home') 
    end
  end

  context 'GET #about' do
    before(:each) { get :about }
    it_behaves_like 'accessible_route', :about, 'application'
    it 'sets active to about' do
      expect(flash[:active]).to eq('about') 
    end
  end
end
