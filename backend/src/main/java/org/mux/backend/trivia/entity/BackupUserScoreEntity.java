package org.mux.backend.trivia.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mux.backend.authentication.entity.UserEntity;

import java.time.LocalDateTime;

@Entity
@Table(name = "backup_user_score_entity")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BackupUserScoreEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_name", referencedColumnName = "userName")
    private UserEntity userEntity;

    @ManyToOne
    @JoinColumn(name = "trivia_id", referencedColumnName = "id")
    private TriviaEntity triviaEntity;

    @Column(nullable = false, columnDefinition = "INT DEFAULT 0")
    private int score;

    @Column(nullable = false)
    private LocalDateTime submissionDateTime;
}
