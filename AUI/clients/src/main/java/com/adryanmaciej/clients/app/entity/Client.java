package com.adryanmaciej.clients.app.entity;

import lombok.*;
import lombok.experimental.SuperBuilder;

import javax.persistence.*;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@Entity
@Table(name = "clients")
public class Client {
    @Id
    @GeneratedValue
    private UUID id;

    @Column
    private String name;

    @Column
    private String surname;

    @Column
    private Integer age;
}
