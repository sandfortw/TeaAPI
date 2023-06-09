Summary:

This was a project for the Turing School of Software and Design that is meant to simulate a take-home assignment for a candidate who is interviewing with a company. The project requirements asked for:
* An endpoint to subscribe a customer to a tea subscription
* An endpoint to cancel a customer’s tea subscription
* An endpoint to see all of a customer’s subsciptions (active and cancelled)

Setup Intructions:
This project is run on Ruby 3.1.1 and Rails 7

To set up this project, you must clone down this repo, and in the terminal for the repository, then run `bundle` in your terminal.
Then run `bundle exec rails db:{create,migrate,seed}` to create and seed the database.
To run the test suite run `bundle exec rspec`

Finally, you can run this on localhost by running `rails s`

After all of this, you should be able to test the endpoint in postman here:
https://www.postman.com/turing-school-of-software-and-design-student-plan-team-2/workspace/inner-worlds/collection/26406576-a9fdb66e-0226-492f-ba96-2d5b1620c703?action=share&creator=26406576

End Points:

To Show all of a customer's subscriptions
GET /api/v1/customers/:customer_id/subscriptions
Example Response:

![image](https://github.com/sandfortw/TeaAPI/assets/80081206/fe3c0af1-f2e5-4ee1-a749-9021736da5b5)

To Delete a subscription for a customer
DELETE /api/v1/customers/:customer_id/subscriptions/:id
Example Response:

![image](https://github.com/sandfortw/TeaAPI/assets/80081206/a3dbb552-3171-464d-b6fa-d9e58cef9f09)

To Add a subscription for a customer
POST /api/v1/customers/:customer_id/subscriptions/:id
Example Response:

![image](https://github.com/sandfortw/TeaAPI/assets/80081206/fd7862ea-26cd-4efa-b262-67d086465b41)


Database:

![image](https://github.com/sandfortw/TeaAPI/assets/80081206/528886fb-30f3-4f6a-b991-3d10a15ead16)
