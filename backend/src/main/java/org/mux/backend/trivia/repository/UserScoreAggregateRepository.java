package org.mux.backend.trivia.repository;

import org.mux.backend.trivia.entity.UserScoreAggregateEntity;
import org.mux.backend.trivia.model.AggregateScore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface UserScoreAggregateRepository extends JpaRepository<UserScoreAggregateEntity, Integer> {

    @Query("SELECT usa FROM UserScoreAggregateEntity usa WHERE usa.userEntity.userName = :username AND usa.date = :date")
    UserScoreAggregateEntity findByUserNameAndDate(String username, LocalDate date);

    @Query("SELECT usa FROM UserScoreAggregateEntity usa WHERE usa.userEntity.userName = :username")
    Optional<List<AggregateScore>> findAllByUserName(String username);
}
