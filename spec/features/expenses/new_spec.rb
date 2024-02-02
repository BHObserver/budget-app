RSpec.feature 'Expenses::News', type: :feature do
  before(:each) do
    @user = create_user
    @expense1 = create_expense(user: @user)
    log_in_user(@user)
    visit new_expense_path
  end

  private

  def valid_icon_path
    Rails.root.join('spec', 'fixtures', 'files', 'icon.png')
  end
end
