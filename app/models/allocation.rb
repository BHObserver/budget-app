class Allocation < ApplicationRecord
  belongs_to :expense
  belongs_to :payment

  validates :expense_id, uniqueness: { scope: :payment_id }
end
