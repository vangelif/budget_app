# spec/requests/categories_spec.rb

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:each) do
    # Set the default_url_options for ActionMailer
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  end

  describe 'GET /index' do
    it 'returns http success when user is signed in' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password123')
      sign_in user

      get categories_path

      expect(response).to have_http_status(:success).or have_http_status(:found)
    end

    it 'returns http success when user is not signed in' do
      get categories_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_category_path
      expect(response).to have_http_status(:success)
    end
  end

  # Add more tests as needed for other actions in the categories controller
end
