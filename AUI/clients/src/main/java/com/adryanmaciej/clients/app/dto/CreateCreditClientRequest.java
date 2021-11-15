package com.adryanmaciej.clients.app.dto;

import lombok.*;

import java.util.UUID;
import java.util.function.Function;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class CreateCreditClientRequest {
    private UUID Id;

    @Getter
    @Setter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor(access = AccessLevel.PUBLIC)
    @ToString
    @EqualsAndHashCode
    public static
    class CreditClient {
        private UUID id;
    }
    public static Function<CreditClient, CreateCreditClientRequest> entityToDtoMapper(){
        return entity -> CreateCreditClientRequest.builder()
                .Id(entity.getId())
                .build();
    }
}
