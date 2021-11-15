package com.adryanmaciej.credits.app.dto;

import lombok.*;
import com.adryanmaciej.credits.app.entity.Credit;

import java.util.function.BiFunction;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@EqualsAndHashCode
public class UpdateCreditRequest {

    private int price;
    private String description;

    public static BiFunction<Credit, UpdateCreditRequest, Credit> dtoToEntityMapper(){
        return (credit, updateCreditRequest) -> {
          credit.setPrice(updateCreditRequest.getPrice());
          credit.setDescription(updateCreditRequest.getDescription());
          return credit;
        };
    }
}
