class Category < ApplicationRecord
    has_many :expenses
    has_many :accounts, through: :expenses
end