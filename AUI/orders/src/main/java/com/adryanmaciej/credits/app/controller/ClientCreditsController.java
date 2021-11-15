package com.adryanmaciej.credits.app.controller;

import com.adryanmaciej.credits.app.dto.CreateClientRequest;
import com.adryanmaciej.credits.app.dto.GetCreditsResponse;
import com.adryanmaciej.credits.app.service.CreditService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import com.adryanmaciej.credits.app.entity.Client;
import com.adryanmaciej.credits.app.repository.JpaCreditRepository;
import com.adryanmaciej.credits.app.service.ClientService;

import java.util.UUID;

@RestController
@RequestMapping("api/clients")
public class ClientCreditsController {

    private ClientService clientService;

    private CreditService creditService;

    @Autowired
    public ClientCreditsController(ClientService clientService, CreditService creditService){
        this.clientService = clientService;
        this.creditService = creditService;
    }


    @GetMapping("{id}/credits")
    public ResponseEntity<GetCreditsResponse> getClientCredits(@PathVariable("id") UUID id){
        var clientEntity = this.clientService.find(id);
        if (clientEntity.isPresent()){
            var credits = this.creditService.findAllByClient(clientEntity.get());
            return ResponseEntity.ok(GetCreditsResponse.entityToDtoMapper().apply(credits));
        }
        else
            return ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<Void> createClient(@RequestBody CreateClientRequest request, UriComponentsBuilder builder){
        Client client = CreateClientRequest.dtoToEntityMapper().apply(request);
        client = this.clientService.create(client);
        return ResponseEntity.created(builder.pathSegment("api", "clients", "{id}").buildAndExpand(client.getId()).toUri()).build();
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Void> deleteClient(@PathVariable("id") UUID id){
        var client = this.clientService.find(id);
        if (client.isPresent()){
            var credits = this.creditService.findAllByClient(client.get());
            this.creditService.deleteAll(credits);
            this.clientService.delete(client.get());
            return ResponseEntity.accepted().build();
        }
        else return ResponseEntity.notFound().build();
    }

}
