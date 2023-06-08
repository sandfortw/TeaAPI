module Api
  module V1
    class SubscriptionsController < ApplicationController
      def index
        customer = Customer.find(params[:customer_id])
        subscriptions = customer.subscriptions
        render json: subscriptions
      end

      def create
        customer = Customer.find(params[:customer_id])
        subscription = Subscription.find(params[:subscription_id])
        customer.subscriptions << subscription
        render json: customer.subscriptions
      end

      def destroy
        customer = Customer.find(params[:customer_id])
        deleted = customer.subscriptions.delete(params[:subscription_id])
        render json: deleted
      end
    end
  end
end