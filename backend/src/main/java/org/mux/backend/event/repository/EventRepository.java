package org.mux.backend.event.repository;

import org.mux.backend.event.entity.EventEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EventRepository extends JpaRepository<EventEntity, Integer> {
    @Query("SELECT e FROM EventEntity e WHERE e.startTime >= CURRENT_DATE AND DATE_PART('week', e.startTime) = DATE_PART('week', CURRENT_DATE) ORDER BY e.startTime DESC LIMIT :count")
    List<EventEntity> findEventsForCurrentWeek(@Param("count") int count);
}
