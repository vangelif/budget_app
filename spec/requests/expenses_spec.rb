# spec/requests/expenses_spec.rb

require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  before(:each) do
    # Set the default_url_options for ActionMailer
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  end

  describe 'GET /index' do
    it 'returns http success' do
      user = User.new(name: 'John Doe', email: 'john@example.com', password: 'password123')
      user.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expense = Expense.new(name: 'Groceries', amount: 50.0, user:)
      expense.save

      get expenses_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      user = User.new(name: 'John Doe', email: 'john@example.com', password: 'password123')
      user.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get new_expense_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new expense' do
      user = User.new(name: 'John Doe', email: 'john@example.com', password: 'password123')
      user.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # Sample category creation for testing
      category = Category.create(name: 'Groceries', user:)
      expense_params = {
        expense: {
          name: 'Groceries',
          amount: 50.0,
          category_ids: [category.id]
        }
      }
      expect do
        post expenses_path, params: expense_params
      end.to change(Expense, :count).by(1)
      expect(response).to redirect_to(category_path(category))
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys an existing expense' do
      user = User.new(name: 'John Doe', email: 'john@example.com', password: 'password123')
      user.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expense = Expense.new(name: 'Groceries', amount: 50.0, user:)
      expense.save

      expect do
        delete expense_path(expense)
      end.to change(Expense, :count).by(-1)

      expected_redirect_url = URI.parse(categories_path.chomp('/')).path
      actual_redirect_url = URI.parse(response.location.chomp('/')).path
      expect(actual_redirect_url).to eq(expected_redirect_url)
    end
  end
end
