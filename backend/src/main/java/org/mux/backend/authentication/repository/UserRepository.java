package org.mux.backend.authentication.repository;

import org.mux.backend.authentication.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    UserEntity findByUserName(String username);
    boolean existsByUserName(String username);
    boolean existsByEmail(String email);
}
