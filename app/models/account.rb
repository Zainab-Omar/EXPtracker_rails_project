class Account < ApplicationRecord
    belongs_to :user
    has_many :expenses, :dependent => :delete_all
    has_many :categories, through: :expenses

    validates :name, presence: true #, uniqueness: true
    validates :amount, presence: true, numericality: { greater_than: 0 }

    scope :order_by_amount, -> {order('accounts.amount DESC')}
    #scope :find_by_category, -{where('name?', "%#{params[:q]}%")}

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



