package org.mux.backend.trivia.repository;

import org.mux.backend.trivia.entity.TriviaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface TriviaRepository extends JpaRepository<TriviaEntity, Integer> {
    @Query(value = "SELECT * FROM trivia ORDER BY id LIMIT 1", nativeQuery = true)
    TriviaEntity findOneRow();
}
