class Account < ApplicationRecord
    belongs_to :user
    has_many :expenses
    has_many :categories, through: :expenses
end