class Account < ApplicationRecord
    belongs_to :user
    has_many :expenses
    has_many :categories, through: :expenses

    validates :name, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }

    scope :recent_expenses, -> {order('account.expenses.updated_at DESC')}
end