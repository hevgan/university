package com.adryanmaciej.credits.app.dto;

import lombok.*;
import com.adryanmaciej.credits.app.entity.Client;
import com.adryanmaciej.credits.app.entity.Credit;

import java.time.LocalDate;
import java.util.UUID;
import java.util.function.Function;
import java.util.function.Supplier;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class CreateCreditRequest {
    private UUID clientId;
    private int price;
    private String description;

    public static Function<CreateCreditRequest, Credit> dtoToEntityMapper(
            Supplier<Client> clientSupplier){
        return createCreditRequest -> Credit.builder()
                .price(createCreditRequest.getPrice())
                .description(createCreditRequest.getDescription())
                .date(LocalDate.now())
                .client(clientSupplier.get())
                .build();
    }
}
