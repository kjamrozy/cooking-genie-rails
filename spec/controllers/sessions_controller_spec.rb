require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include SessionsHelper
  context 'GET /signin' do
    before(:each) { get :new }
    it 'renders before_auth layout' do
      expect(response).to render_template('layouts/before_auth')
    end
    it 'renders sessions/new template' do
      expect(response).to render_template(:new)
    end
  end
  context 'POST /signin' do
    context 'with valid email and password' do
      let(:user) { create(:user) }
      let(:password) { attributes_for(:user).extract!(:password) }
      before(:each) { post :create, email: user.email, password: password }
      it 'redirects to user page' do
        expect(response).to redirect_to("/users/#{user.id}")
      end

      it 'logs user in' do
        expect(logged_in?).to be_truthy
      end
    end

    context 'with invalid email and password' do
      let(:email) { 'invalid@one.net' }
      let(:password) { 'nyan_cat' }
      before(:each) { post :create, email: email, password: password }
      it 'fails to log user in' do
        expect(logged_in?).to be_falsey
      end

      it 'renders sessions/new tempate' do
        expect(response).to render_template(:new)
      end

      it 'renders before_auth layout' do
        expect(response).to render_template('layouts/before_auth')
      end

      it 'sets @errors' do
        expect(assigns[:errors]).to eq ['Invalid email/password']
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
