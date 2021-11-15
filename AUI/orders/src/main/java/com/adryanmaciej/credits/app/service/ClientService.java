package com.adryanmaciej.credits.app.service;

import com.adryanmaciej.credits.app.entity.Client;
import com.adryanmaciej.credits.app.repository.JpaClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class ClientService {

    private final JpaClientRepository repository;

    @Autowired
    public ClientService(JpaClientRepository repository) {
        this.repository = repository;
    }

    public Optional<Client> find(UUID id) {
        return repository.findById(id);
    }

    public List<Client> findAll() {
        return repository.findAll();
    }

    @Transactional
    public Client create(Client entity) {
       return repository.save(entity);
    }
    @Transactional
    public void delete(Client entity) {
        repository.delete(entity);
    }
}
