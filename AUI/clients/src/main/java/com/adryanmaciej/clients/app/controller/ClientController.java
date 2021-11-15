package com.adryanmaciej.clients.app.controller;

import com.adryanmaciej.clients.app.dto.*;
import com.adryanmaciej.clients.app.entity.Client;
import com.adryanmaciej.clients.app.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import com.adryanmaciej.clients.app.service.ClientCreditService;

import java.util.UUID;


@RestController
@RequestMapping("api/clients")
public class ClientController {

    private final ClientService clientService;
    private final ClientCreditService clientCreditService;

    @Autowired
    public ClientController(ClientService clientService, ClientCreditService clientCreditService){
        this.clientService = clientService;
        this.clientCreditService = clientCreditService;
    }

    @GetMapping
    public ResponseEntity<GetClientsResponse> getClients(){
        return ResponseEntity.ok(GetClientsResponse.entityToDtoMapper().apply(clientService.findAll()));
    }

    @GetMapping("{id}")
    public ResponseEntity<GetClientResponse> getClient(@PathVariable("id") UUID id){
        var clientEntity = this.clientService.find(id);
        return clientEntity.map(value -> ResponseEntity.ok(GetClientResponse.entityToDtoMapper().apply(value)))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Void> createClient(@RequestBody CreateClientRequest request, UriComponentsBuilder builder){
        Client client = CreateClientRequest.dtoToEntityMapper().apply(request);
        client = this.clientService.create(client);
        this.clientCreditService.create(new CreateCreditClientRequest.CreditClient(client.getId()));
        return ResponseEntity.created(builder.pathSegment("api", "clients", "{id}").buildAndExpand(client.getId()).toUri()).build();
    }

    @PutMapping("{id}")
    public ResponseEntity<Void> updateClient(@RequestBody UpdateClientRequest request, @PathVariable("id") UUID id){
        var client = this.clientService.find(id);
        if (client.isPresent()){
            UpdateClientRequest.dtoToEntityMapper().apply(client.get(), request);
            this.clientService.update(client.get());
            return ResponseEntity.accepted().build();
        }
        else return ResponseEntity.notFound().build();
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Void> deleteClient(@PathVariable("id") UUID id){
        var client = this.clientService.find(id);
        if (client.isPresent()){
            this.clientService.delete(client.get());
            this.clientCreditService.delete(client.get());
            return ResponseEntity.accepted().build();
        }
        else return ResponseEntity.notFound().build();
    }
}
