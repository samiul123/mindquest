package org.mux.backend.discussion.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mux.backend.authentication.entity.UserEntity;

import java.time.LocalDateTime;

@Entity
@Table(name = "Comment")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CommentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username", referencedColumnName = "userName")
    private UserEntity userEntity;

    @Column(nullable = false)
    private String body;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id", referencedColumnName = "id")
    private PostEntity post;
}
