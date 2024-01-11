# spec/model/expense_spec.rb

require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password123') }

  before { subject.save }
  before(:each) do
    # Set the default_url_options for ActionMailer
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  end

  it 'is not valid without a name' do
    expense = Expense.new(amount: 50.0, user: user)
    expect(expense).to_not be_valid
  end

  it 'is not valid without an amount' do
    expense = Expense.new(name: 'Groceries', user: user)
    expect(expense).to_not be_valid
  end

  it 'is not valid with a negative amount' do
    expense = Expense.new(name: 'Groceries', amount: -20.0, user: user)
    expect(expense).to_not be_valid
  end

  it 'is valid with a name, a non-negative amount, and a user' do
    expense = Expense.new(name: 'Groceries', amount: 50.0, user: user)
    expect(expense).to be_valid
  end

  it 'belongs to a user' do
    expense = Expense.new(name: 'Groceries', amount: 50.0, user: user)
    expect(expense.user).to eq(user)
  end

  it 'has and belongs to many categories' do
    category1 = Category.create(name: 'Food', user: user)
    category2 = Category.create(name: 'Shopping', user: user)

    expense = Expense.new(name: 'Groceries', amount: 50.0, user: user)
    expense.categories << category1
    expense.categories << category2

    expect(expense.categories).to include(category1, category2)
  end
end
