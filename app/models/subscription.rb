# frozen_string_literal: true

class Subscription < ApplicationRecord
  enum status: %i[inactive active canceled]
  enum frequency: %i[weekly monthly yearly]
  validates_presence_of :status, :frequency
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true, uniqueness: true

  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
end
