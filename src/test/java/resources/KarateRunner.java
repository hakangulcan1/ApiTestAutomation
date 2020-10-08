package resources;


import com.intuit.karate.junit5.Karate;
import io.qameta.allure.Epic;
import io.qameta.allure.Story;

public class KarateRunner {

    private static final String BASE_PATH = "classpath:resources/";


    @Epic("Customers")
    @Story("Customers Apilerini Test Eder")
    @Karate.Test
    Karate testCustomers() {
        return new Karate().feature(BASE_PATH + "customers");
    }

}
