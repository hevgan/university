package com.adryanmaciej.clients.initializer;

import com.adryanmaciej.clients.app.dto.CreateCreditClientRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.adryanmaciej.clients.app.entity.Client;
import com.adryanmaciej.clients.app.service.ClientService;
import com.adryanmaciej.clients.app.service.ClientCreditService;

import javax.annotation.PostConstruct;

@Component
public class DataInitializer {

    private final ClientService clientService;
    private final ClientCreditService clientCreditService;

    @Autowired
    public DataInitializer(ClientService clientService, ClientCreditService clientCreditService) {
        this.clientService = clientService;
        this.clientCreditService = clientCreditService;
    }

    @PostConstruct
    void init(){
        Client client1 = Client.builder()
                .name("Adam")
                .surname("Sandler")
                .build();
        this.clientService.create(client1);
        this.clientCreditService.create(new CreateCreditClientRequest.CreditClient(client1.getId()));

        Client client2 = Client.builder()
                .name("Max")
                .surname("Kolonko")
                .build();
        this.clientService.create(client2);
        this.clientCreditService.create(new CreateCreditClientRequest.CreditClient(client2.getId()));

        Client client3 = Client.builder()
                .name("Chuck")
                .surname("Norris")
                .build();
        this.clientService.create(client3);
        this.clientCreditService.create(new CreateCreditClientRequest.CreditClient(client3.getId()));
    }

}
