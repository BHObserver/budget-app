class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :expenses
  has_many :payments, foreign_key: 'author_id'

  validates :name, presence: true
end
