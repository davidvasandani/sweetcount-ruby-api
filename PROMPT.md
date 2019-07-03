# DevOps Interview Prompt
The purpose of this document is to provide a prompt for potential candidates.

## Goal
Develop a service, using a node or ruby, that increments a count via a POST call, and returns that count via a GET call.  Since we want to persist the count, please also include a data store of your choice in this project.  Ideally this should all be packaged in a Docker container(s).

## Acceptance Criteria
The service should increment the count with a POST call to `http://localhost:3000/count` (an empty body is ok).  The response should include the new count, i.e. `{ "count": 1 }`

It should return the count with a GET call to `http://localhost:3000/count` with the shape `{ "count": 1 }`

As part of the acceptance criteria, the provided integration tests should all pass.  To run the tests, first make sure that you have [newman](l) installed: `npm install -g newman`.  There is a provided script to run the tests in the `tests` directory: `./tests/run_tests.sh`

## Deliverable
Fork this repo and submit a PR when you are finished.  In the provided fork, please provide instruction on how to bring up the service (i.e. Makefile, bash script, docker command, etc)

## Bonus
Any tests that you develop as part of this exercise are welcome and encouraged.  Additionally, if you would like to provide extra functionality (i.e. PUT method, CI configs, linting configs), that is also welcome.
