package com.adryanmaciej.clients.app.dto;

import lombok.*;
import com.adryanmaciej.clients.app.entity.Client;

import java.util.function.Function;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class CreateClientRequest {
    private String name;
    private String surname;

    public static Function<CreateClientRequest, Client> dtoToEntityMapper(){
        return createClientRequest -> Client.builder()
                .name(createClientRequest.getName())
                .surname(createClientRequest.getSurname())
                .build();
    }
}
