package org.mux.backend.trivia.model;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TriviaResponse {
    @NonNull
    private Integer id;
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
}
