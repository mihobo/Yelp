require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  let!(:dirty_burger) { Restaurant.create(name: "Dirty Burger",
    description: "Hipster Burger Joint" ) }

  describe "GET /" do
    it "responds with HTTP 200" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    it "responds with 200" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /" do
    let!(:byron) { post :create, params: { restaurant: { name: "Byron",
      description: "Normie Burger Joint" } } }

    it "Redirects to /restaurants" do
      expect(response).to redirect_to(restaurants_path)
    end

    it "Creates a new restaurant" do
      expect(Restaurant.find_by(name: "Byron")).to be
    end
  end

  describe "GET /:id" do
    it "responds with 200" do
      get :show, params: { id: dirty_burger.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    it "responds with 200" do
      get :edit, params: { id: dirty_burger.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /update" do
    before { put :update, params: { id: dirty_burger.id, restaurant: { name: "Dirty Burger",
      description: "Best burgers in London" } } }
  end

  it "Redirects to /restaurants" do

  end

  it "Updates a restaurant entry" do

  end
end
