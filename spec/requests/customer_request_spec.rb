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
        

      end
    end
  end
end