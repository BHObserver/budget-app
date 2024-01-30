require 'rails_helper'

RSpec.feature 'Expenses::Shows', type: :feature do
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
    @expense2 = Expense.create(
      name: 'Expense 3',
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon2.png'), 'image/png'),
      user_id: @user.id
    )

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    visit expense_path(@expense1)
  end

  scenario 'displays expense details' do
    expect(page).to have_content(@expense1.name)
    expect(page).to have_content(@expense1.total_payment_amount)
    expect(page).to have_link('Add Transaction', href: new_expense_payment_path(@expense1))
  end
end
