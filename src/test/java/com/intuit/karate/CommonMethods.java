package com.intuit.karate;

import io.qameta.allure.Step;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.junit.Assert;

public class CommonMethods {


    public static final Logger log = Logger.getLogger(CommonMethods.class);


    @Step("Random String Üretilir")
    public static String createRandomString(int size) {
        log.info("Size: " + size);
        Assert.assertNotEquals("size 0 olamaz!", size, 0);
        return RandomStringUtils.randomAlphanumeric(size);
    }

}
