package org.mux.backend.trivia.controller;

import org.mux.backend.trivia.model.AggregateScore;
import org.mux.backend.trivia.model.TriviaDto;
import org.mux.backend.trivia.model.TriviaResponse;
import org.mux.backend.trivia.model.UserScoreDto;
import org.mux.backend.trivia.service.TriviaService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class TriviaController {
    private final TriviaService triviaService;

    public TriviaController(TriviaService triviaService) {
        this.triviaService = triviaService;
    }

    @PostMapping("/trivia")
    public ResponseEntity<String> createTrivia(@RequestBody TriviaDto trivia) {
        triviaService.createTrivia(trivia);
        return new ResponseEntity<>("Trivia Created", HttpStatus.CREATED);
    }

    @PostMapping("/trivia/submit")
    public ResponseEntity<Boolean> submitTrivia(@RequestBody UserScoreDto userScoreDto) {
        return new ResponseEntity<>(triviaService.checkAnswer(userScoreDto), HttpStatus.OK);
    }


    @GetMapping("/trivia/next")
    public ResponseEntity<TriviaResponse> getTrivia() throws Exception {
        TriviaResponse trivia = triviaService.getTrivia();
        return new ResponseEntity<>(trivia, HttpStatus.OK);
    }

    @GetMapping("/trivia/agg-score")
    public ResponseEntity<List<AggregateScore>> getAggregatedScore() {
        List<AggregateScore> aggregatedScore = triviaService.getAggregatedScore();
        return new ResponseEntity<>(aggregatedScore, HttpStatus.OK);
    }
}
