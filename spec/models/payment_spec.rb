require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:user) { User.create(name: 'user 1') }
  let(:payment) do
    Payment.create(
      name: 'Expense 1',
      amount: 10,
      author_id: user.id
    )
  end

  it 'name should be present' do
    payment.name = nil
    expect(payment).to_not be_valid
  end

  it 'amount should be present' do
    payment.amount = nil
    expect(payment).to_not be_valid
  end

  it 'amount should be number' do
    payment.amount = 'ten'
    expect(payment).to_not be_valid
  end
end
