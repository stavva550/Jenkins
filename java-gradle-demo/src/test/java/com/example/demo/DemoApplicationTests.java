package com.example.demo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class DemoApplicationTests {

    @Test
    void testApplicationMessage() {
        String message = "Hello from Java Gradle Demo";

        assertEquals(
                "Hello from Java Gradle Demo",
                message
        );
    }
}