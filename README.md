# Sweetcount System

The Sweetcount System increments a count via a POST call, and returns that count via a GET call.

To start the application:  
`docker-compose up -d`

To tails the logs:  
`docker-compose logs -f`

To test the application:  
`./tests/run_tests.sh`  
_**NOTE:** this requires newman_  
`npm install -g newman`