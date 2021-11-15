package com.adryanmaciej.credits.initializer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.adryanmaciej.credits.app.entity.Client;
import com.adryanmaciej.credits.app.entity.Credit;
import com.adryanmaciej.credits.app.service.ClientService;
import com.adryanmaciej.credits.app.service.CreditService;

import javax.annotation.PostConstruct;
import java.time.LocalDate;

@Component
public class DataInitializer {

    private final ClientService clientService;
    private final CreditService creditService;

    @Autowired
    public DataInitializer(ClientService clientService, CreditService creditService) {
        this.clientService = clientService;
        this.creditService = creditService;
    }

    @PostConstruct
    void start(){
        new Thread(this::init).start();
    }

    void init() {
        while (clientService.findAll().stream().count() < 3){}
        var clients = clientService.findAll();

        Client client1 = clients.get(0);
        Client client2 = clients.get(1);
        Client client3 = clients.get(2);


        Credit credit1 = Credit.builder()
                .price(120)
                .date(LocalDate.of(2021,5,5))
                .client(client1)
                .description("Paint restoration")
                .build();
        this.creditService.create(credit1);

        Credit credit2 = Credit.builder()
                .price(121300)
                .date(LocalDate.of(2021,3,15))
                .client(client1)
                .description("Interior cleaning")
                .build();
        this.creditService.create(credit2);

        Credit credit3 = Credit.builder()
                .price(10000)
                .date(LocalDate.of(2021,5,13))
                .client(client1)
                .description("Wheels detailing")
                .build();
        this.creditService.create(credit3);

        Credit credit4 = Credit.builder()
                .price(1000)
                .date(LocalDate.of(2021,4,11))
                .client(client1)
                .description("Interior cleaning")
                .build();
        this.creditService.create(credit4);

        Credit credit5 = Credit.builder()
                .price(1000)
                .date(LocalDate.of(2021,3,2))
                .client(client2)
                .description("Paint restoration")
                .build();
        this.creditService.create(credit5);

        Credit credit6 = Credit.builder()
                .price(1000)
                .date(LocalDate.of(2021,2,5))
                .client(client3)
                .description("Wheels detailing")
                .build();
        this.creditService.create(credit6);

        Credit credit7 = Credit.builder()
                .price(1000)
                .date(LocalDate.of(2021,1,23))
                .client(client3)
                .description("Interior cleaning")
                .build();
        this.creditService.create(credit7);
    }

}
