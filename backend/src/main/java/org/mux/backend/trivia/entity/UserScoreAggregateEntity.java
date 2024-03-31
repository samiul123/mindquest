package org.mux.backend.trivia.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mux.backend.authentication.entity.UserEntity;

import java.time.LocalDate;

@Entity
@Table(name = "user_score_aggregate")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserScoreAggregateEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_name", referencedColumnName = "userName")
    private UserEntity userEntity;

    @Column(nullable = false)
    private LocalDate date;

    private int aggregatedScore;
}
