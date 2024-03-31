package org.mux.backend.trivia.service;

import jakarta.persistence.EntityNotFoundException;
import org.mux.backend.authentication.entity.UserEntity;
import org.mux.backend.authentication.repository.UserRepository;
import org.mux.backend.trivia.entity.BackupUserScoreEntity;
import org.mux.backend.trivia.entity.TriviaEntity;
import org.mux.backend.trivia.entity.UserScoreEntity;
import org.mux.backend.trivia.model.TriviaDto;
import org.mux.backend.trivia.model.TriviaResponse;
import org.mux.backend.trivia.model.UserScoreDto;
import org.mux.backend.trivia.repository.BackupUserScoreRepository;
import org.mux.backend.trivia.repository.TriviaRepository;
import org.mux.backend.trivia.repository.UserScoreRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class TriviaService {
    private final TriviaRepository triviaRepository;
    private final UserRepository userRepository;
    private final UserScoreRepository userScoreRepository;
    private final BackupUserScoreRepository backupUserScoreRepository;

    public TriviaService(TriviaRepository triviaRepository,
                         UserRepository userRepository,
                         UserScoreRepository userScoreRepository,
                         BackupUserScoreRepository backupUserScoreRepository) {
        this.triviaRepository = triviaRepository;
        this.userRepository = userRepository;
        this.userScoreRepository = userScoreRepository;
        this.backupUserScoreRepository = backupUserScoreRepository;
    }

    public void createTrivia(TriviaDto triviaDto) {
        triviaRepository.save(TriviaEntity.builder()
                .question(triviaDto.getQuestion())
                .optionA(triviaDto.getOptionA())
                .optionB(triviaDto.getOptionB())
                .optionC(triviaDto.getOptionC())
                .optionD(triviaDto.getOptionD())
                .correctOption(triviaDto.getCorrectOption())
                .createDateTime(LocalDateTime.now())
                .point(triviaDto.getPoint())
                .build());
    }

    public TriviaResponse getTrivia(String username) throws Exception {
        List<TriviaEntity> allTrivia = triviaRepository.findAll();
        if (allTrivia.isEmpty()) {
            throw new EntityNotFoundException("Trivia not found");
        }

        List<UserScoreEntity> attemptedTrivia = userScoreRepository.findAllByUsername(username);
        if (attemptedTrivia.isEmpty()) {
            TriviaEntity triviaEntity = triviaRepository.findOneRow();
            return TriviaResponse.builder()
                    .id(triviaEntity.getId())
                    .question(triviaEntity.getQuestion())
                    .optionA(triviaEntity.getOptionA())
                    .optionB(triviaEntity.getOptionB())
                    .optionC(triviaEntity.getOptionC())
                    .optionD(triviaEntity.getOptionD())
                    .build();
        }

        //TODO: pagination
        Optional<TriviaResponse> nextUnattemptedTrivia = allTrivia.stream()
                .filter(trivia -> attemptedTrivia.stream()
                        .noneMatch(userScore -> Objects.equals(userScore.getTriviaEntity().getId(), trivia.getId())))
                .map(triviaEntity -> TriviaResponse.builder()
                        .id(triviaEntity.getId())
                        .question(triviaEntity.getQuestion())
                        .optionA(triviaEntity.getOptionA())
                        .optionB(triviaEntity.getOptionB())
                        .optionC(triviaEntity.getOptionC())
                        .optionD(triviaEntity.getOptionD())
                        .build())
                .limit(1)
                .findFirst();
        if (nextUnattemptedTrivia.isPresent()) {
            return nextUnattemptedTrivia.get();
        }
        backupUserScoreRepository.saveAll(attemptedTrivia.stream().map(userScoreEntity ->
                BackupUserScoreEntity.builder()
                        .userEntity(userScoreEntity.getUserEntity())
                        .triviaEntity(userScoreEntity.getTriviaEntity())
                        .score(userScoreEntity.getScore())
                        .submissionDateTime(userScoreEntity.getSubmissionDateTime())
                        .build()).collect(Collectors.toList()));
        userScoreRepository.deleteAllInBatch(attemptedTrivia);
        TriviaEntity triviaEntity = triviaRepository.findOneRow();
        return TriviaResponse.builder()
                .id(triviaEntity.getId())
                .question(triviaEntity.getQuestion())
                .optionA(triviaEntity.getOptionA())
                .optionB(triviaEntity.getOptionB())
                .optionC(triviaEntity.getOptionC())
                .optionD(triviaEntity.getOptionD())
                .build();
    }

    public boolean checkAnswer(UserScoreDto userScoreDto) {
        UserEntity userEntity = userRepository.findByUserName(userScoreDto.getUsername());
        Optional<TriviaEntity> submittedTrivia = Optional.ofNullable(triviaRepository.findById(userScoreDto.getTriviaId())
                .orElseThrow(() -> new EntityNotFoundException("Trivia not found")));
        boolean check = submittedTrivia.get().getCorrectOption().equals(userScoreDto.getChoice());
        UserScoreEntity userScoreEntity = UserScoreEntity.builder()
                .userEntity(userEntity)
                .triviaEntity(submittedTrivia.get())
                .score(check ? submittedTrivia.get().getPoint() : 0)
                .submissionDateTime(LocalDateTime.now())
                .build();
        userScoreRepository.save(userScoreEntity);

        return check;
    }
}
