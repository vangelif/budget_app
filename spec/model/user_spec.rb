require 'rails_helper'

# ./spec/model/user_spec.rb

RSpec.describe User, type: :model do
  before(:each) do
    # Set the default_url_options for ActionMailer
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  end

  subject { User.new(name: 'John Doe', email: 'doe@john.com', password: '123456') }
  before { subject.save }

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'sends confirmation email with a valid host', :skip_confirmation_email do
    skip 'Confirmation email test skipped for invalid user' if subject.invalid?

    confirmation_email = Devise.mailer.deliveries.last
    raise 'No confirmation email sent' unless confirmation_email

    confirmation_url = confirmation_email.body.to_s.match(%r{href="(https?://[^"]+)})[1]
    expect(confirmation_url).to include('localhost:3000')
  end

  it 'is valid with a password' do
    expect(subject).to be_valid
  end

  it 'has many expenses' do
    expense = Expense.new(name: 'Groceries', amount: 50.0)
    subject.expenses << expense
    expect(subject.expenses).to include(expense)
  end

  it 'destroys dependent expenses when destroyed' do
    expense = Expense.new(name: 'Groceries', amount: 50.0)
    subject.expenses << expense
    subject.destroy
    expect(Expense.find_by(id: expense.id)).to be_nil
  end

  it 'has many categories' do
    category = Category.new(name: 'Food')
    subject.categories << category
    expect(subject.categories).to include(category)
  end
end
