package com.adryanmaciej.credits.app.service;

import com.adryanmaciej.credits.app.entity.Client;
import com.adryanmaciej.credits.app.entity.Credit;
import com.adryanmaciej.credits.app.repository.JpaCreditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CreditService {

    private final JpaCreditRepository repository;

    @Autowired
    public CreditService(JpaCreditRepository repository) {
        this.repository = repository;
    }

    public Optional<Credit> find(UUID id) {
        return repository.findById(id);
    }

    public List<Credit> findAll() {
        return repository.findAll();
    }

    public List<Credit> findAllByClient(Client client) { return repository.findAllByClient(client); }

    @Transactional
    public Credit create(Credit entity) {
        return repository.save(entity);
    }

    @Transactional
    public void delete(Credit entity) {
        repository.delete(entity);
    }

    @Transactional
    public void update(Credit entity) {
        repository.save(entity);
    }

    public void deleteAll(List<Credit> credits) {
        repository.deleteAll(credits);
    }
}
