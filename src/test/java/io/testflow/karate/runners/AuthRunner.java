package io.testflow.karate.runners;

import com.intuit.karate.junit5.Karate;

class AuthRunner {

    @Karate.Test
    Karate auth() {
        return Karate.run("classpath:features")
                .tags("@auth");
    }
}
