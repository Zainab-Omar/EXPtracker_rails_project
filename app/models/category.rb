class Category < ApplicationRecord
    has_many :expenses
    has_many :accounts, through: :expenses

    validates :name, presence: true, uniqueness: true
    before_validation :titleize_name

    def titleize_name
        self.name = self.name.titleize
      end
end