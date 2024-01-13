# spec/requests/splash_spec.rb

require 'rails_helper'

RSpec.describe 'Splashes', type: :request do
  before(:each) do
    # Set the default_url_options for ActionMailer
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  end

  describe 'GET /index' do
    it 'returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  # You can add more tests for other actions in the splash controller if needed
end
