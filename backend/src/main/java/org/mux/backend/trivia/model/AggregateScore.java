package org.mux.backend.trivia.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AggregateScore {
    private LocalDate date;
    private Integer aggregatedScore;
}
