package org.mux.backend.discussion.repository;

import org.mux.backend.discussion.entity.CommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CommentRepository extends JpaRepository<CommentEntity, Integer> {
    @Query(value = "SELECT c FROM CommentEntity c WHERE c.post.id = :postId")
    List<CommentEntity> findByPostId(Integer postId);
}
