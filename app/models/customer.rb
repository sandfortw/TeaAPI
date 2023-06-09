# frozen_string_literal: true

class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :address
  validates :email, presence: true, uniqueness: true

  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
  has_many :teas, through: :subscriptions
end
