package com.adryanmaciej;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;

@SpringBootApplication
public class ApiGateway {

    /**
     * Application main entry point. Starts Spring Boot application context.
     *
     * @param args command line arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(ApiGateway.class, args);
    }

    /**
     * Generally the {@link Bean} annotated methods are producer methods returning Spring configuration beans. This
     * method registers Gateway routing rules.
     *
     * @param builder provided route locator builder
     * @return route locator with defined routes
     */
    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder
                .routes()
                .route("clients", r -> r
                        .host("localhost:8080")
                        .and()
                        .path("/api/clients/{id}", "/api/clients")
                        .uri("http://localhost:8081"))
                .route("credits", r -> r
                        .host("localhost:8080")
                        .and()
                        .path("/api/credits", "/api/credits/**", "/api/clients/{id}/credits", "/api/clients/{id}/credits/**")
                        .uri("http://localhost:8082"))
                .build();
    }

    @Bean
    public CorsWebFilter corsWebFilter() {

        final CorsConfiguration corsConfig = new CorsConfiguration();
        corsConfig.setAllowedOrigins(Collections.singletonList("*"));
        corsConfig.setMaxAge(3600L);
        corsConfig.setAllowedMethods(Arrays.asList("GET", "POST", "DELETE", "PUT"));
        corsConfig.addAllowedHeader("*");

        final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfig);

        return new CorsWebFilter(source);
    }
}
