require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include SessionsHelper
  context 'GET /signin' do
    before(:each) { get :new }
    it_behaves_like 'accessible_route', :new, 'before_auth'
  end
  context 'POST /signin' do
    context 'with valid email and password' do
      let(:user) { create(:user) }
      let(:password) { attributes_for(:user).extract!(:password) }
      before(:each) { post :create, email: user.email, password: password }
      it 'redirects to root path' do
        expect(response).to redirect_to('/')
      end

      it 'logs user in' do
        expect(logged_in?).to be_truthy
      end
    end

    context 'with invalid email and password' do
      let(:email) { 'invalid@one.net' }
      let(:password) { 'nyan_cat' }
      before(:each) { post :create, email: email, password: password }
      it_behaves_like 'accessible_route', :new, 'before_auth'
      it 'fails to log user in' do
        expect(logged_in?).to be_falsey
      end

      it 'sets flash[:errors]' do
        expect(flash[:errors]).to eq ['Invalid email/password']
      end
    end
  end

  context 'GET /logout' do
    let(:user) { create(:user) }
    before(:each) do
      log_in(user)
      get :destroy
    end
    it 'logs user out' do
      expect(logged_in?).to be_falsey
    end

    it 'sets notice flash' do
      expect(flash[:notice]).to eq 'Successfully logged out!'
    end

    it 'redirects to the sign in page' do
      expect(response).to redirect_to('/signin')
    end
  end
end
