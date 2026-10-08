package io.testflow.karate.runners;

import com.intuit.karate.junit5.Karate;

class ApiRunner {

    @Karate.Test
    Karate api() {
        return Karate.run("classpath:features")
                .tags("@api");
    }
}
