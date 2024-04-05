package org.mux.backend.discussion.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mux.backend.authentication.entity.UserEntity;
import org.mux.backend.discussion.model.PostCategory;

import java.time.LocalDateTime;

@Entity
@Table(name = "Post")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PostEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String subject;

    @Column(nullable = false)
    private String body;

    @Column(nullable = false)
    private String postCategory;

    @ManyToOne
    @JoinColumn(name = "username", referencedColumnName = "userName")
    private UserEntity userEntity;

    @Column(nullable = false)
    private LocalDateTime createdAt;
}
