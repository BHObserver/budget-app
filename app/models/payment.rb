class Payment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :allocations
  has_many :expenses, through: :allocations

  validates :name, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :at_least_one_expense_selected

  private

  def at_least_one_expense_selected
    errors.add(:base, 'Please select at least one expense') if expenses.empty?
  end
end
