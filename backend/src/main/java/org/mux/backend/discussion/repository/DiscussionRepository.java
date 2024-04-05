package org.mux.backend.discussion.repository;


import org.mux.backend.discussion.entity.PostEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiscussionRepository extends JpaRepository<PostEntity, Integer> {
}
