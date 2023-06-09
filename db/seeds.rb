# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do
  customer = Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  )
  3.times do
    subscription = Subscription.create(
      title: Faker::Subscription.plan,
      price: Faker::Number.decimal(l_digits: 2),
      status: Faker::Number.between(from: 0, to: 2),
      frequency: Faker::Number.between(from: 0, to: 2)
    )
    CustomerSubscription.create(
      customer_id: customer.id,
      subscription_id: subscription.id
    )
    tea = Tea.create(
      title: Faker::Tea.variety,
      description: Faker::Tea.type,
      temperature: Faker::Number.between(from: 120, to: 212),
      brew_time: Faker::Number.between(from: 1, to: 10)
    )
    TeaSubscription.create(
      tea_id: tea.id,
      subscription_id: subscription.id
    )
  end
end
