# karateApiTests

`to install dependencies please run the command below:`

> mvn clean install -DskipTests

`to compile the project please run the command below:`

> mvn clean compile

`to run Karate api test please run the command below:`

> mvn test -Dtest=KarateRunner#testCustomers

`to generate to Allure reports please run the command belows after test run:`

> allure generate target/allure-results -o target/new

`to open the Allure report please run the command belows after allure generated:`

> allure open target/new