class Expense < ApplicationRecord
    belongs_to :category
    belongs_to :account
    belongs_to :user

    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :description, :date, :category_name, presence: true

    #scope :recent, -> {order('expenses.date DESC').limit(5)}


    def category_name=(name)
        self.category = Category.find_or_create_by(name: name)
    end
    
    def category_name
        self.category ? self.category.name : nil
    end

    def date_time
        self.date.strftime("%d %b %Y %l:%M %p")
    end

end

