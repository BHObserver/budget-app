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

    )
  end

  def fill_in_and_submit_payment_form(name, amount)
    fill_in 'payment_name', with: name
    fill_in 'payment_amount', with: amount
    click_button 'Create Transaction'
  end
end
