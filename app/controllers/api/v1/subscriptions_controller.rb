module Api
  module V1
    class SubscriptionsController < ApplicationController
      def index
        customer = Customer.find(params[:customer_id])
        subscriptions = customer.subscriptions
        render json: SubscriptionSerializer.new(subscriptions).serializable_hash
      end

      def create
        customer = Customer.find(params[:customer_id])
        subscription = Subscription.find(params[:subscription_id])
        customer.subscriptions << subscription
        render json: SubscriptionSerializer.new(subscription).serializable_hash
      end

      def destroy
        customer = Customer.find(params[:customer_id])
        deleted = customer.subscriptions.delete(params[:subscription_id])
        render json: SubscriptionSerializer.new(subscription).serializable_hash
      end
    end
  end
end