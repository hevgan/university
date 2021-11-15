package com.adryanmaciej.credits.app.dto;

import lombok.*;
import com.adryanmaciej.credits.app.entity.Credit;

import java.util.UUID;
import java.util.function.Function;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class GetCreditResponse {

    private UUID id;
    private UUID clientId;
    private int price;
    private String description;

    public static Function<Credit, GetCreditResponse> entityToDtoMapper(){
        return credit -> GetCreditResponse.builder()
                .id(credit.getId())
                .clientId(credit.getClient().getId())
                .price(credit.getPrice())
                .description(credit.getDescription())
                .build();
    }
}
