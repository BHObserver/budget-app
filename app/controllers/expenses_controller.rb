class ExpensesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @expenses = current_user.expenses
  end

  def show
    @expense = current_user.expenses
      .includes(allocations: { payment: :allocations })
      .order('allocations.created_at DESC')
      .find(params[:id])
  end

  def new
    @expense = current_user.expenses.build
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      redirect_to expenses_path, notice: 'Expense was successfully created'
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :icon)
  end
end
