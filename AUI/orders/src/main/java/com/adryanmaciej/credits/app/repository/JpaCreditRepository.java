package com.adryanmaciej.credits.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.adryanmaciej.credits.app.entity.Client;
import com.adryanmaciej.credits.app.entity.Credit;

import java.util.List;
import java.util.UUID;

@Repository
public interface JpaCreditRepository extends JpaRepository<Credit, UUID> {
    public List<Credit> findAllByClient(Client client);
}
