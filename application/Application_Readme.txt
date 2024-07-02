1. To run this application, you need to first install the packages. I have freezed out the packages installed in my system. But, you can just install flask, mysql-connector and python-dotenv
2. You also need to create a database named visitors in your mysql and run the Schema in your database before starting the application. 
3. To test the POST Request. Do "curl -X POST http://3.149.249.63:5000/add_visitor -d '{"name": "Ahson Shaikh"}' -H 'Content-Type: application/json'"
4. To test the GET Request. Do "curl -X GET http://3.149.249.63:5000/visitors
5. To run the application, you have to do python main.py
6. While your application is running, then you can execute the tests, by simply installing pytest package and running command "pytest". It will automatically pickup. 