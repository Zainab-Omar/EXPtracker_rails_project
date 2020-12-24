class User < ApplicationRecord
    
    has_many :expenses
    has_many :categories, through: :expenses
    has_many :accounts
    has_secure_password
    
    validates :username, :password, presence: true
    validates :email, presence: true, uniqueness: true

    before_validation :titleize_name

    def titleize_name
        self.username = self.username.titleize
    end

end