package org.mux.backend.trivia.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserScoreDto {
    private String username;
    private Integer triviaId;
    private Integer score;
    private String choice;
    private LocalDateTime submissionTIme;
}
