require 'rails_helper'

RSpec.describe 'Customer Subscriptions API' do
  describe 'GET /api/v1/customers/:customer_id/subscriptions' do
    describe 'happy path' do
      it 'can get all subscriptions for a customer' do
        customer = create(:customer)
        3.times do
          customer.subscriptions << create(:subscription)
        end
        get "/api/v1/customers/#{customer.id}/subscriptions"
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response[:data].count).to eq(3)
        response[:data].each do |subscription|
          expect(subscription.keys).to contain_exactly(:id, :type, :attributes)
          expect(subscription[:attributes].keys).to contain_exactly(:title, :price, :status, :frequency)
        end
      end
    end
  end


  describe 'DELETE /api/v1/customers/:customer_id/subscriptions/:id' do
    describe 'happy path' do
      it 'can delete a subscription for a customer' do
        customer = create(:customer)
        subscription = create(:subscription)
        customer.subscriptions << subscription
        expect(customer.subscriptions.count).to eq(1)
        delete "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}"
        expect(response.status).to eq(200)
        expect(customer.subscriptions.count).to eq(0)
        response = JSON.parse(@response.body, symbolize_names: true)
        expect(response[:data].first[:id]).to eq(subscription.id.to_s)
        expect(response[:data].first[:attributes]).to eq({title: subscription.title, 
                                                          price: subscription.price, 
                                                          status: subscription.status,
                                                          frequency: subscription.frequency})

      end
    end
  end
end