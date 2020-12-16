class Expense < ApplicationRecord
    belongs_to :category
    belongs_to :account
    belongs_to :user
end

#bi-directional has_many through