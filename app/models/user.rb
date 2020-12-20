class User < ApplicationRecord
    # has_many :incomes #or accounts
    has_many :expenses
    has_many :categories, through: :expenses
    has_many :accounts
    has_secure_password
    #accepts_nested_attributes_for :accounts
    validates :username, :password, presence: true
    validates :email, presence: true, uniqueness: true

end