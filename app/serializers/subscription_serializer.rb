# frozen_string_literal: true

class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency
end
