module Api
  module V1
    class SubscriptionsController < ApplicationController
      def index
        customer = Customer.find(params[:customer_id])
        subscriptions = customer.subscriptions
        render json: subscriptions
      end
    end
  end
end