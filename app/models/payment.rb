class Payment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :allocations
  has_many :expenses, through: :allocations



  private

  def at_least_one_expense_selected
    errors.add(:base, 'Please select at least one expense') if expenses.empty?
  end
end
