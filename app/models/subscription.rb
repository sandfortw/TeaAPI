class Subscription < ApplicationRecord
  enum status: [:inactive, :active, :canceled]
  enum frequency: [:weekly, :monthly, :yearly]

  
end
