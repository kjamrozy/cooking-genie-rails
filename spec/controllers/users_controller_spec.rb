require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views
  describe 'GET #index' do
    before { get :index }
    it 'assigns @users' do
      expect(assigns[:users]).to eq(User.all)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    before { get :show, id: user.id }
    it 'assigns @user' do
      expect(assigns[:user]).to eq(User.find(user.id))
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    before { get :new }
    it 'assigns @user' do
      expect(assigns[:user]).to be_a_new(User)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end

    it 'renders before_auth layout' do
      expect(response).to render_template(layout: 'before_auth')
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    context 'provided with invalid data' do
      before { get :create, user: attributes_for(:user, name: '') }
      it 'renders new template' do
        expect(response).to render_template(:new)
      end

      it 'renders before_auth layout' do
        expect(response).to render_template(layout: 'before_auth')
      end
    end

    context 'provided with valid data' do
      it 'inserts new record to the database' do
        expect { get :create, user: attributes_for(:user) }
          .to change { User.count }.by(1)
      end

      it 'redirects to user page upon creation' do
        get :create, user: attributes_for(:user)
        expect(response).to redirect_to("/users/#{assigns[:user].id}")
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    before { get :edit, id: user.id }
    it 'assigns @user' do
      expect(assigns[:user]).to eq(User.find(user.id))
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #update' do
    let(:user) { create(:user) }
    before do
      put :update, id: user.id, user: attributes_for(:user, name: 'Richard')
    end
    it 'should update user data' do
      expect(user.reload.name).to eq('Richard')
    end

    it 'redirects to the user page' do
      expect(response).to redirect_to("/users/#{user.id}")
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
