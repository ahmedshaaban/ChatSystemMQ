# Chat System


Assume that the system is to receive many requests so we will face a race ocondition, using rabbitmq queues will over come this problem
The main idea behind Work Queues (aka: Task Queues) is to avoid doing a resource-intensive task immediately and having to wait for it to complete. Instead we schedule the task to be done later. We encapsulate a task as a message and send it to a queue. A worker process running in the background will pop the tasks and eventually execute the job. When you run many workers the tasks will be shared between them.

This concept is especially useful in web applications where it's impossible to handle a complex task during a short HTTP request window.

![alt text](https://www.rabbitmq.com/img/tutorials/python-two.png)

so we will have a queue for chat and a queue for messages

* Ruby version
    - ruby 2.5.1p57

* System dependencies
    - Mysql (PostgreSQL) 5.7.24
    - Rails 5.2.1
    - RabbitMQ
    - Redis

* How to run the docker-compose
    - before running please make sure that you have redis, rabbitmq and mysql disabled on your device 
    - docker-compose build
    - docker-compose up

---------------------------------

* Import postman collection from Instabug.postman_collection.json file
    - use postman to test endpoints
----------------------------------

Run Native

* Configuration
    - change the values in .env.copy and remove the .copy

* Database creation
    - rake db:create

* Database initialization
    - rake db:migrate


