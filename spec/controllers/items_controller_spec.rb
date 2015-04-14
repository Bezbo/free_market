require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

  before { @item = FactoryGirl.create(:item) }
  before { @admin = FactoryGirl.create(:admin) }
  before { @user = FactoryGirl.create(:user, email: "user@example.com") }

  describe "GET #index" do

    it "populates an array of items" do
      get :index
      expect(assigns(:items)).to eq [ @item ]
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do

    it "assigns the requested item to @item" do
      get :show, id: @item
      expect(assigns(:item)).to eq @item
    end

    it "renders the :show view" do
      get :show, id: @item
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do

    context "for signed in user" do

      before { sign_in_as(@user) }

      it "renders the :new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "for not signed in user" do

      it "redirects to sign in" do
        get :new
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST #create" do

    describe "for signed in user" do

      before { sign_in_as(@user) }

      context "with valid attributes" do

        it "creates a new item" do
          expect {
            post :create, item: FactoryGirl.attributes_for(:item)
          }.to change(Item, :count).by(1)
        end

        it "redirects to the new item" do
          post :create, item: FactoryGirl.attributes_for(:item)
          expect(response).to redirect_to Item.last
        end
      end

      context "with invalid attributes" do

        it "does not save the new item" do
          expect{
            post :create, item: FactoryGirl.attributes_for(:invalid_item)
          }.to_not change(Item, :count)
        end

        it "re-renders the new method" do
          post :create, item: FactoryGirl.attributes_for(:invalid_item)
          expect(response).to render_template :new
        end
      end
    end

    describe "for not signed in user" do

      it "does not save the new item" do
        expect {
          post :create, item: FactoryGirl.attributes_for(:item)
        }.to_not change(Item, :count)
      end

      it "redirects to sign in" do
        post :create, item: FactoryGirl.attributes_for(:item)
        expect(response).to redirect_to sign_in_path
      end

    end
  end

  describe 'DELETE #destroy' do

    context "for allowed user" do

      before { sign_in_as(@admin) }

      it "deletes the item" do
        expect{
          delete :destroy, id: @item
        }.to change(Item,:count).by(-1)
      end

      it "redirects to items#index" do
        delete :destroy, id: @item
        expect(response).to redirect_to items_path
      end
    end

    context "for not allowed user" do

      it "redirects to sign in" do
        delete :destroy, id: @item
        expect(response).to redirect_to sign_in_path
      end
    end
  end

end
