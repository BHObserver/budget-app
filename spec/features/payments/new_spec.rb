require 'rails_helper'

RSpec.feature 'Payments::News', type: :feature do
  before(:each) do
    @user = create_user
    @expense1 = create_expense(name: 'Expense 2', icon_path: 'icon.png', user: @user)

    log_in_user(@user)
    visit new_expense_payment_path(@expense1)
  end

  def create_user
    User.create(
      id: 2,
      name: 'becky',
      email: 'becky@mail.com',
      password: 'abcxyz123',
      confirmed_at: Time.now
    )
  end

  def create_expense(name:, icon_path:, user:)
    Expense.create(
      name:,
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', icon_path), 'image/png'),
      user_id: user.id
    )
  end

  def log_in_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def fill_in_and_submit_payment_form(name, amount)
    fill_in 'payment_name', with: name
    fill_in 'payment_amount', with: amount
    click_button 'Create Transaction'
  end
end
