# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < ApplicationController
      def index
        customer = Customer.find(params[:customer_id])
        subscriptions = customer.subscriptions
        render json: SubscriptionSerializer.new(subscriptions).serializable_hash
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Customer not found' }, status: :not_found
      end

      def create
        customer = Customer.find(params[:customer_id])
        subscription = Subscription.find(params[:subscription_id])
        customer.subscriptions << subscription
        render json: SubscriptionSerializer.new(subscription).serializable_hash
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
      end

      def destroy
        customer = Customer.find(params[:customer_id])
        deleted = customer.subscriptions.delete(params[:id])
        render json: SubscriptionSerializer.new(deleted.first).serializable_hash
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
      end
    end
  end
end
