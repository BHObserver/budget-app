class Expense < ApplicationRecord
  belongs_to :user
  has_many :allocations
  has_many :payments, through: :allocations

  validates :name, :icon, presence: true
  has_one_attached :icon

  def total_payment_amount
    payments.sum(:amount)
  end
end
