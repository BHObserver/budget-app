require 'rails_helper'

RSpec.feature 'Expenses::News', type: :feature do
  before(:each) do
    @user = User.create(
      id: 2,
      name: 'becky',
      email: 'becky@mail.com',
      password: 'abcxyz123',
      confirmed_at: Time.now
    )
    @expense1 = Expense.create(
      name: 'Expense 2',
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon.png'), 'image/png'),
      user_id: @user.id
    )

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit new_expense_path
  end

  scenario 'User creates a new expense with valid data' do
    fill_in 'expense_name', with: 'Test Expense'
    attach_file 'expense_icon', Rails.root.join('spec', 'fixtures', 'files', 'icon.png')
    click_button 'Save'

    expect(page).to have_content('Add Category')
  end

  scenario 'User tries to create a new expense with invalid data' do
    click_button 'Save'

    expect(page).to have_content('New Category')
  end
end
