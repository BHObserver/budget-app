require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  before(:each) do
    @user = User.create(
      id: 2,
      name: 'becky',
      email: 'becky@mail.com',
      password: 'abcxyz123',
      confirmed_at: Time.now
    )
    @expense = Expense.create(
      name: 'Expense 2',
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon.png'), 'image/png'),
      user_id: @user.id
    )
    sign_in @user
  end
  describe 'GET /new' do
    it 'renders the new template' do
      get new_expense_payment_path(@expense)
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    it 'creates a new payment' do
      payment_params = {
        payment: {
          name: 'Payment 1',
          amount: 100,
          expense_ids: [@expense.id]
        }
      }

      expect do
        post expense_payments_path(@expense), params: payment_params
      end.to change(Payment, :count).by(1)

      expect(response).to redirect_to(expense_path(@expense))
      expect(flash[:notice]).to eq('Payment was created successfully')
    end
  end
end
