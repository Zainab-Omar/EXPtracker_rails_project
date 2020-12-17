class User < ApplicationRecord
    # has_many :incomes #or accounts
    has_many :expenses
    has_many :categories, through: :expenses
    has_many :accounts
    has_secure_password
    accepts_nested_attributes_for :accounts
end