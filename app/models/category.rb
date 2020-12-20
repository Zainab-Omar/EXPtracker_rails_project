class Category < ApplicationRecord
    has_many :expenses
    has_many :accounts, through: :expenses

    validates :name, presence: true, uniqueness: true
end