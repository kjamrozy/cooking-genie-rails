require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include SessionsHelper
  render_views

  context 'with user not logged' do
    describe 'GET #index' do
      before { get :index }
      it_behaves_like 'authorized_route'
    end

    describe 'GET #show' do
      let(:user) { create(:user) }
      before { get :show, id: user.id }
      it_behaves_like 'authorized_route'
    end

    describe 'GET #edit' do
      let(:user) { create(:user) }
      before { get :edit, id: user.id }
      it_behaves_like 'authorized_route'
    end

    describe 'GET #update' do
      let(:user) { create(:user) }
      before do
        put :update, id: user.id, user: attributes_for(:user, name: 'Richard')
      end
      it_behaves_like 'authorized_route'
    end

    describe 'GET #destroy' do
      let!(:user) { create(:user) }
      before { get :destroy, id: user.id }
      it_behaves_like 'authorized_route'
    end
  end

  context 'with user logged in' do
    # log in user
    before do
      user = create(:user)
      log_in(user)
    end

    describe 'GET #index' do
      before { get :index }
      it_behaves_like 'accessible_route', :index, 'application'
      context 'with user logged in' do
        it 'assigns @users' do
              expect(assigns[:users]).to eq(User.all)
        end
      end
    end

    describe 'GET #show' do
      let(:user) { create(:user) }
      before { get :show, id: user.id }
      it_behaves_like 'accessible_route', :show, 'application'
      it 'assigns @user' do
        expect(assigns[:user]).to eq(User.find(user.id))
      end
    end

    describe 'GET #new' do
      before { get :new }
      it_behaves_like 'accessible_route', :new, 'before_auth'
      it 'assigns @user' do
        expect(assigns[:user]).to be_a_new(User)
      end
    end

    describe 'GET #create' do
      context 'provided with invalid data' do
        before { get :create, user: attributes_for(:user, name: '') }
        it_behaves_like 'accessible_route', :new, 'before_auth'

        it 'assigns flash[:errors]' do
          expect(flash[:errors]).to be_present
        end
      end

      context 'provided with valid data' do
        it 'inserts new record to the database' do
          expect { get :create, user: attributes_for(:user) }
            .to change { User.count }.by(1)
        end

        it 'signs user in' do
          expect(logged_in?).to be_truthy
        end

        it 'redirects to root path upon creation' do
          get :create, user: attributes_for(:user)
          expect(response).to redirect_to('/')
        end
      end
    end

    describe 'GET #edit' do
      let(:user) { create(:user) }
      before { get :edit, id: user.id }
      it_behaves_like 'accessible_route', :edit, 'application'
      it 'assigns @user' do
        expect(assigns[:user]).to eq(User.find(user.id))
      end
    end

    describe 'GET #update' do
      let(:user) { create(:user) }
      context 'with valid current_password' do
        before do
          user_attrs = attributes_for(:user, name: 'Richard')
          user_attrs[:current_password] = attributes_for(:user)[:password]
          put :update, id: user.id, user: user_attrs
        end
        it 'updates user data' do
          expect(user.reload.name).to eq('Richard')
        end
      end

      context 'with invalid current_password' do
        before do
          user_attrs = attributes_for(:user, name: 'Richard')
          user_attrs[:current_password] = user_attrs[:password] + '_invalid'
          put :update, id: user.id, user: user_attrs
        end
        it 'fails to update user' do
          expect(user.reload.name).not_to eq('Richard')
        end

        it 'sets flash[:errors]' do
          expect(flash[:errors]).to eq(['Invalid current password!'])
        end
      end

      it 'redirects to the edit user page' do
        put :update, id: user.id, user: attributes_for(:user)
        expect(response).to redirect_to("/users/#{user.id}/edit")
      end
    end

    describe 'GET #destroy' do
      let!(:user) { create(:user) }
      before { get :destroy, id: user.id }
      it 'deletes user' do
        expect { User.find(user.id) }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'redirects to sign up(new action) page' do
        expect(response).to redirect_to('/signup')
      end
    end
  end
end
