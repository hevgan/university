package com.adryanmaciej.credits.app.controller;

import com.adryanmaciej.credits.app.dto.CreateCreditRequest;
import com.adryanmaciej.credits.app.dto.GetCreditResponse;
import com.adryanmaciej.credits.app.dto.GetCreditsResponse;
import com.adryanmaciej.credits.app.dto.UpdateCreditRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import com.adryanmaciej.credits.app.service.ClientService;
import com.adryanmaciej.credits.app.service.CreditService;

import java.util.UUID;

@RestController
@RequestMapping("api/credits")
public class CreditController {

    private final ClientService clientService;
    private final CreditService creditService;

    @Autowired
    public CreditController(ClientService clientService, CreditService creditService){
        this.clientService = clientService;
        this.creditService = creditService;
    }

    @GetMapping
    public ResponseEntity<GetCreditsResponse> getCredits(){
        return ResponseEntity.ok(GetCreditsResponse.entityToDtoMapper().apply(creditService.findAll()));
    }

    @GetMapping("{id}")
    public ResponseEntity<GetCreditResponse> getCredit(@PathVariable("id") UUID id){
        var creditEntity = this.creditService.find(id);
        return creditEntity.map(value -> ResponseEntity.ok(GetCreditResponse.entityToDtoMapper().apply(value)))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping()
    public ResponseEntity<Void> createCredit(@RequestBody CreateCreditRequest request, UriComponentsBuilder builder){
        var clientId = request.getClientId();
        var credit = CreateCreditRequest
                .dtoToEntityMapper(() -> this.clientService.find(clientId).orElse(null))
                .apply(request);
        credit = this.creditService.create(credit);
        return ResponseEntity.created(builder.pathSegment("api", "credits", "{id}").buildAndExpand(credit.getId()).toUri()).build();
    }

    @PutMapping("{id}")
    public ResponseEntity<Void> updateCredit(@PathVariable("id") UUID id, @RequestBody UpdateCreditRequest request){
        var credit = this.creditService.find(id);
        if (credit.isPresent()){
            UpdateCreditRequest.dtoToEntityMapper().apply(credit.get(), request);
            this.creditService.update(credit.get());
            return ResponseEntity.accepted().build();
        }
        else return ResponseEntity.notFound().build();
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Void> deleteCredit(@PathVariable("id") UUID id){
        var credit = this.creditService.find(id);
        if (credit.isPresent()){
            this.creditService.delete(credit.get());
            return ResponseEntity.accepted().build();
        }
        else return ResponseEntity.notFound().build();
    }
}
