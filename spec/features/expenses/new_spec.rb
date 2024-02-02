RSpec.feature 'Expenses::News', type: :feature do
  before(:each) do
    @user = create_user
    @expense1 = create_expense(user: @user)
    log_in_user(@user)
    visit new_expense_path
  end

  scenario 'User creates a new expense with valid data' do
    fill_in_and_submit_expense_form('Test Expense', valid_icon_path)

    expect(page).to have_content('Add Category')
  end

  scenario 'User tries to create a new expense with invalid data' do
    click_button 'Save'

    expect(page).to have_content('New Category')
  end

  private

  def valid_icon_path
    Rails.root.join('spec', 'fixtures', 'files', 'icon.png')
  end
end
