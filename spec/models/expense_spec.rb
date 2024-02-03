require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create(name: 'user 1') }
  let(:expense) do
    Expense.create(
      name: 'Expense 1',
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon.png'), 'image/png'),
      user_id: user.id
    )
  end

  it 'name should be present' do
    expense.name = nil
    expect(expense).to_not be_valid
  end

  it 'icon should be present' do
    expense.icon = nil
    expect(expense).to_not be_valid
  end

  it 'icon should be attached' do
    expect(expense.icon).to be_attached
  end

  it 'should return total payment amount' do
    expect(expense.total_payment_amount).to eq(0)
  end
end
