package com.adryanmaciej.credits.app.dto;

import lombok.*;

import java.util.Collection;
import java.util.List;
import java.util.UUID;
import java.util.function.Function;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class GetCreditsResponse {

    @Getter
    @Setter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor(access = AccessLevel.PRIVATE)
    @ToString
    @EqualsAndHashCode
    public static class Credit{
        private UUID id;
        private String description;
    }

    @Singular
    private List<Credit> credits;

    public static Function<Collection<com.adryanmaciej.credits.app.entity.Credit>, GetCreditsResponse> entityToDtoMapper(){
        return credits -> {
            GetCreditsResponseBuilder response = GetCreditsResponse.builder();
            credits.stream()
                    .map(credit -> Credit.builder()
                            .id(credit.getId())
                            .description(credit.getDescription())
                            .build())
                    .forEach(response::credit);
            return response.build();
        };
    }
}
