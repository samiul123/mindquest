package org.mux.backend.trivia.repository;

import org.mux.backend.trivia.entity.BackupUserScoreEntity;
import org.mux.backend.trivia.entity.UserScoreEntity;
import org.mux.backend.trivia.model.AggregateScore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface BackupUserScoreRepository extends JpaRepository<BackupUserScoreEntity, Integer> {
    @Query(value = "SELECT DATE(us.submissionDateTime) as date, " +
            "SUM(us.score) as aggregatedScore FROM BackupUserScoreEntity us WHERE us.userEntity.userName = :username " +
            "GROUP BY date")
    Optional<List<BackupUserScoreEntity>> aggregateScoreForUser(@Param("username") String username);

    @Query("SELECT bus FROM BackupUserScoreEntity bus WHERE bus.userEntity.userName = :username")
    List<BackupUserScoreEntity> findAllByUsername(@Param("username") String username);
}
