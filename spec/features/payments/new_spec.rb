require 'rails_helper'

RSpec.feature 'Payments::News', type: :feature do
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
    visit new_expense_payment_path(@expense1)
  end

  scenario 'User creates a new payment with valid data' do
    fill_in 'payment_name', with: 'Test Payment'
    fill_in 'payment_amount', with: 100.00

    click_button 'Create Transaction'

    expect(page).to have_content('New Transaction')
  end

  scenario 'User tries to create a new payment with invalid data' do
    click_button 'Create Transaction'

    expect(page).to have_content('New Transaction')
  end
end
