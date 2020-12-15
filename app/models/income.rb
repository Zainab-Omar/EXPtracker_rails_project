class Income < ApplicationRecord
    has_many :expenses
    has_many :categories, through: :expenses
end
