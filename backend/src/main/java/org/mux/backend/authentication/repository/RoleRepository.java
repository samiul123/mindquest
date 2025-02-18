package org.mux.backend.authentication.repository;

import org.mux.backend.authentication.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<RoleEntity, Integer> {
    Optional<RoleEntity> findByName(String name);
    boolean existsByName(String name);
}
