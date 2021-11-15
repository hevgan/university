package com.adryanmaciej.clients.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.adryanmaciej.clients.app.entity.Client;

import java.util.UUID;

@Repository
public interface JpaClientRepository extends JpaRepository<Client, UUID> {

}
