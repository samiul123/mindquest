package org.mux.backend.trivia.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mux.backend.authentication.entity.UserEntity;

import java.time.LocalDateTime;

@Entity
@Table(name = "Userscore")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserScoreEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

//    @Column(name = "username", insertable = false, updatable = false)
//    private String username;

    @ManyToOne
//    @Column(name = "username")
    @JoinColumn(name = "user_name", referencedColumnName = "userName")
    private UserEntity userEntity;

//    @Column(name = "trivia_id", insertable = false, updatable = false)
//    private Integer triviaId;

    @ManyToOne
//    @Column(name = "trivia_id")
    @JoinColumn(name = "trivia_id", referencedColumnName = "id")
    private TriviaEntity triviaEntity;

    @Column(nullable = false, columnDefinition = "INT DEFAULT 0")
    private int score;

    @Column(nullable = false)
    private LocalDateTime submissionDateTime;
}
