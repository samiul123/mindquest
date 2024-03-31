package org.mux.backend.trivia.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class TriviaDto {
    @NonNull
    private String question;
    @NonNull
    private String optionA;
    @NonNull
    private String optionB;
    @NonNull
    private String optionC;
    @NonNull
    private String optionD;
    @NonNull
    private String correctOption;
    private int point = 1;
}
