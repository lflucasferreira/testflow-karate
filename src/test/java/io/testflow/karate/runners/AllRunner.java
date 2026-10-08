package io.testflow.karate.runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Runs every feature under classpath:features.
 * Tag filters come from -Dkarate.options="--tags @smoke" or Maven profiles.
 */
class AllRunner {

    @Test
    void testAll() {
        Results results = Runner.path("classpath:features")
                .outputCucumberJson(true)
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
