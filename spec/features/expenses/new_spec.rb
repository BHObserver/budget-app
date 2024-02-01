require 'rails_helper'

RSpec.feature 'Expenses::News', type: :feature do
  before(:each) do
    @user = create_user
    @expense1 = create_expense(user: @user)

    log_in_user(@user)
    visit new_expense_path
  end

  scenario 'User creates a new expense with valid data' do
    fill_in_and_submit_expense_form('Test Expense', Rails.root.join('spec', 'fixtures', 'files', 'icon.png'))

    expect(page).to have_content('Add Category')
  end

  scenario 'User tries to create a new expense with invalid data' do
    click_button 'Save'

    expect(page).to have_content('New Category')
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

  def create_expense(user:)
    Expense.create(
      name: 'Expense 2',
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon.png'), 'image/png'),
      user_id: user.id
    )
  end

  def log_in_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def fill_in_and_submit_expense_form(name, icon_path)
    fill_in 'expense_name', with: name
    attach_file 'expense_icon', icon_path
    click_button 'Save'
  end
end
