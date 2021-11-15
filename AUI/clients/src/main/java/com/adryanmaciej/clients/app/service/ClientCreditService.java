package com.adryanmaciej.clients.app.service;

import com.adryanmaciej.clients.app.dto.CreateCreditClientRequest;
import com.adryanmaciej.clients.app.entity.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.transaction.Transactional;


@Service
public class ClientCreditService {

    private final RestTemplate restTemplate;

    @Autowired
    public ClientCreditService(@Value("${credits.url}") String baseUrl) {
        restTemplate = new RestTemplateBuilder().rootUri(baseUrl).build();
    }

    @Transactional
    public void create(CreateCreditClientRequest.CreditClient entity) {
        restTemplate.postForLocation("/clients", CreateCreditClientRequest.entityToDtoMapper().apply(entity));
    }

    @Transactional
    public void delete(Client entity) {
        restTemplate.delete("/clients/{username}", entity.getId());
    }

}
