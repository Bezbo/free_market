require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  before { @user = FactoryGirl.create(:user) }
  before { allow(controller).to receive(:current_user).and_return(@user) }

  describe "GET #index" do

    it "populates an array of users" do
      get :index
      expect(assigns(:users)).to eq [ @user ]
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do

    it "assigns the requested user to @user" do
      get :show, id: @user
      expect(assigns(:user)).to eq @user
    end

    it "renders the :show view" do
      get :show, id: @user
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do

    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    context "with valid attributes" do

      it "creates a new user" do
        expect {
          post :create, user: { name: "bob", email: "bob@example.com", password: "foobar" }
        }.to change(User, :count).by(1)
      end

      it "redirects to the new user" do
        post :create, user: { name: "bob", email: "bob@example.com", password: "foobar" }
        expect(response).to redirect_to User.last
      end
    end

    context "with invalid attributes" do

      it "does not save the new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it "re-renders the new method" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do

    context "valid attributes" do

      it "located the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        put :update, id: @user,
          user: FactoryGirl.attributes_for(:user, name: "Luke Skywalker")
        @user.reload
        expect(@user.name).to eq("Luke Skywalker")
        expect(@user.email).to eq("doe@example.com")
      end

      it "redirects to the updated user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to @user
      end
    end

    context "invalid attributes" do

      it "locates the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        expect(assigns(:user)).to eq(@user)
      end

      it "does not change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Luke Skywalker",
                                                                 email: nil)
        @user.reload
        expect(@user.name).to_not eq("Luke Skywalker")
        expect(@user.email).to eq("doe@example.com")
      end

      it "re-renders the edit method" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do

    it "deletes the user" do
      expect{
        delete :destroy, id: @user
      }.to change(User,:count).by(-1)
    end

    it "redirects to users#index" do
      delete :destroy, id: @user
      expect(response).to redirect_to users_path
    end
  end

end

