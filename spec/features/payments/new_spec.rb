require 'rails_helper'

RSpec.feature 'Payments::News', type: :feature do
  before(:each) do
    @user = create_user
    @expense1 = create_expense(name: 'Expense 2', icon_path: 'icon.png', user: @user)

    log_in_user(@user)
    visit new_expense_payment_path(@expense1)
  end

  scenario 'User creates a new payment with valid data' do
    fill_in_and_submit_payment_form('Test Payment', 100.00)

    expect(page).to have_content('New Transaction')
  end

  scenario 'User tries to create a new payment with invalid data' do
    click_button 'Create Transaction'

    expect(page).to have_content('New Transaction')
  end

  private

  def create_expense(name:, icon_path:, user:)
    Expense.create(
      name:,
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', icon_path), 'image/png'),
      user_id: user.id
    )
  end

  def fill_in_and_submit_payment_form(name, amount)
    fill_in 'payment_name', with: name
    fill_in 'payment_amount', with: amount
    click_button 'Create Transaction'
  end
end
