package org.mux.backend.trivia.repository;

import org.mux.backend.trivia.entity.BackupUserScoreEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BackupUserScoreRepository extends JpaRepository<BackupUserScoreEntity, Integer> {
}
