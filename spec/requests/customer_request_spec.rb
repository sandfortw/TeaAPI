# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer Subscriptions API' do
  describe 'GET /api/v1/customers/:customer_id/subscriptions' do
    before do
      @customer = create(:customer)
      3.times do
        @customer.subscriptions << create(:subscription)
      end
    end
    describe 'happy path' do
      it 'can get all subscriptions for a customer' do
        get "/api/v1/customers/#{@customer.id}/subscriptions"
        expect(response.status).to eq(200)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response[:data].count).to eq(3)
        response[:data].each do |subscription|
          expect(subscription.keys).to contain_exactly(:id, :type, :attributes)
          expect(subscription[:attributes].keys).to contain_exactly(:title, :price, :status, :frequency)
        end
      end
    end

    describe 'sad path' do
      it 'returns 404 if customer not found' do
        get "/api/v1/customers/#{@customer.id + 1}/subscriptions"
        expect(response.status).to eq(404)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response).to eq({:error=>"Customer not found"})
      end
    end
  end

  describe 'DELETE /api/v1/customers/:customer_id/subscriptions/:id' do
    before do 
      @customer = create(:customer)
      @subscription = create(:subscription)
      @customer.subscriptions << @subscription
    end
    describe 'happy path' do
      it 'can delete a subscription for a customer' do
        expect(@customer.subscriptions.count).to eq(1)
        delete "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}"
        expect(response.status).to eq(200)
        expect(@customer.subscriptions.count).to eq(0)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response[:data][:id]).to eq(@subscription.id.to_s)
        expect(response[:data][:attributes]).to eq({ title: @subscription.title,
                                                           price: @subscription.price,
                                                           status: @subscription.status,
                                                           frequency: @subscription.frequency })
      end
    end

    describe 'sad path' do
      it 'returns 404 if customer not found' do
        delete "/api/v1/customers/#{@customer.id + 1}/subscriptions/#{@subscription.id}"
        expect(response.status).to eq(404)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response).to eq({:error=>"Couldn't find Customer with 'id'=#{@customer.id + 1}"})
      end

      it 'returns 404 if subscription not found' do
        delete "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id + 1}"
        expect(response.status).to eq(404)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response[:error]).to include("Couldn't find Subscription with 'id'=#{@subscription.id + 1}")
      end
    end
  end

  describe 'POST /api/v1/customers/:customer_id/subscriptions/:id' do
    before do
      @customer = create(:customer)
      @subscription = create(:subscription)
    end
    describe 'happy path' do
      it 'can add a subsciption to a customer' do
        expect(@customer.subscriptions.count).to eq(0)
        post "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}"
        expect(response.status).to eq(200)
        expect(@customer.subscriptions.count).to eq(1)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response[:data][:id]).to eq(@subscription.id.to_s)
        expect(response[:data][:attributes]).to eq({ title: @subscription.title,
                                                           price: @subscription.price,
                                                           status: @subscription.status,
                                                           frequency: @subscription.frequency })
      end
    end
    describe 'sad path' do
      it 'returns 404 if customer not found' do
        post "/api/v1/customers/#{@customer.id + 1}/subscriptions/#{@subscription.id}"
        expect(response.status).to eq(404)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response).to eq({:error=>"Couldn't find Customer with 'id'=#{@customer.id + 1}"})
      end

      it 'returns 404 if subscription not found' do
        post "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id + 1}"
        expect(response.status).to eq(404)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response[:error]).to include("Couldn't find Subscription with 'id'=#{@subscription.id + 1}")
      end
    end
  end
end
