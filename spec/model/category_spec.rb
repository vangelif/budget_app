require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new(name: 'Food') }
  before { subject.save }
  before(:each) do
    # Set the default_url_options for ActionMailer
    Rails.application.routes.default_url_options[:host] = 'localhost:3000' # Update this with your actual host and port
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'has many expenses' do
    expense1 = Expense.new(name: 'Groceries', amount: 50.0)
    expense2 = Expense.new(name: 'Restaurant', amount: 30.0)
    subject.expenses << expense1
    subject.expenses << expense2

    expect(subject.expenses).to include(expense1, expense2)
  end

  it 'destroys dependent expenses when destroyed' do
    expense = Expense.new(name: 'Groceries', amount: 50.0)
    subject.expenses << expense
    subject.destroy
    expect(Expense.find_by(id: expense.id)).to be_nil
  end

  it 'validates uniqueness of name' do
    duplicate_category = Category.new(name: 'Food')
    expect(duplicate_category).to_not be_valid
  end

  it 'validates presence of attached icon' do
    file_path = Rails.root.join('app', 'assets', 'images', 'test.PNG')
    subject.icon.attach(io: File.open(file_path), filename: 'test.PNG', content_type: 'image/png')
    expect(subject.icon).to be_attached
  end

  it 'allows categories with the same name for different users' do
    user1 = User.create(name: 'User 1', email: 'user1@example.com', password: 'password123')
    user2 = User.create(name: 'User 2', email: 'user2@example.com', password: 'password456')

    category_user1 = Category.create(name: 'MELIS', user: user1)
    category_user2 = Category.create(name: 'LYDIANA', user: user2)

    expect(category_user1).to be_valid
    expect(category_user2).to be_valid
  end
end
