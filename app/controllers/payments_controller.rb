class PaymentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    @payment = current_user.payments.build
    load_expenses
  end

  def create
    @payment = current_user.payments.build(payment_params)

    if @payment.save
      create_allocations
    else
      load_expenses
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :amount, expense_ids: [])
  end

  def load_expenses
    @expense = current_user.expenses.find(params[:expense_id])
    @expenses = current_user.expenses
  end

  def create_allocations
    expense_ids = params[:payment][:expense_ids]
    expense_ids.each do |expense_id|
      Allocation.create(expense_id: expense_id, payment_id: @payment.id)
    end
    redirect_to expense_path(expense_ids[0]), notice: 'Payment was created successfully'
  end
end
