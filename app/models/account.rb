class Account < ApplicationRecord
    belongs_to :user
    has_many :expenses
    has_many :categories, through: :expenses

    validates :name, presence: true #, uniqueness: true
    validates :amount, presence: true, numericality: { greater_than: 0 }

    scope :order_by_amount, -> {order('accounts.amount DESC')}

    def total_expenses
        self.expenses.sum(:amount)
    end
    
    def min_expense
        self.expenses.minimum(:amount)
    end
    
    def max_expense
        self.expenses.maximum(:amount)
    end
    
    def avg_expense
        self.expenses.average(:amount)
    end
    
    def money_left
        self.amount - self.total_expenses
    end
end



