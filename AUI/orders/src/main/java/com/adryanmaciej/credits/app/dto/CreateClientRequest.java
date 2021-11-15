package com.adryanmaciej.credits.app.dto;

import lombok.*;
import com.adryanmaciej.credits.app.entity.Client;

import java.util.UUID;
import java.util.function.Function;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class CreateClientRequest {
    private UUID Id;

    public static Function<CreateClientRequest, Client> dtoToEntityMapper(){
        return createClientRequest -> Client.builder()
                .id(createClientRequest.getId())
                .build();
    }
}
