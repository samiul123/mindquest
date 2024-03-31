package org.mux.backend.trivia.repository;

import org.mux.backend.trivia.entity.UserScoreEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserScoreRepository extends JpaRepository<UserScoreEntity, Integer> {
    @Query("SELECT us FROM UserScoreEntity us WHERE us.userEntity.userName = :username")
    List<UserScoreEntity> findAllByUsername(@Param("username") String username);

//    @Query(value = "SELECT t from TriviaEntity t WHERE t.id NOT IN (SELECT DISTINCT (us.trivia_id) FROM UserScoreEntity us WHERE us.userEntity.userName = :username) LIMIT 1", nativeQuery = true)
//    List<TriviaEntity> findNextUnAttemptedTrivia(@Param("username") String username);
}
