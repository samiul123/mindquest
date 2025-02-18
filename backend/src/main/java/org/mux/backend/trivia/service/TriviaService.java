package org.mux.backend.trivia.service;

import jakarta.persistence.EntityNotFoundException;
import org.mux.backend.authentication.entity.UserEntity;
import org.mux.backend.authentication.repository.UserRepository;
import org.mux.backend.trivia.entity.BackupUserScoreEntity;
import org.mux.backend.trivia.entity.TriviaEntity;
import org.mux.backend.trivia.entity.UserScoreEntity;
import org.mux.backend.trivia.model.*;
import org.mux.backend.trivia.repository.BackupUserScoreRepository;
import org.mux.backend.trivia.repository.TriviaRepository;
import org.mux.backend.trivia.repository.UserScoreAggregateRepository;
import org.mux.backend.trivia.repository.UserScoreRepository;
import org.springframework.cglib.core.Local;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class TriviaService {
    private final TriviaRepository triviaRepository;
    private final UserRepository userRepository;
    private final UserScoreRepository userScoreRepository;
    private final BackupUserScoreRepository backupUserScoreRepository;
    private final UserScoreAggregateRepository userScoreAggregateRepository;

    public TriviaService(TriviaRepository triviaRepository,
                         UserRepository userRepository,
                         UserScoreRepository userScoreRepository,
                         BackupUserScoreRepository backupUserScoreRepository,
                         UserScoreAggregateRepository userScoreAggregateRepository) {
        this.triviaRepository = triviaRepository;
        this.userRepository = userRepository;
        this.userScoreRepository = userScoreRepository;
        this.backupUserScoreRepository = backupUserScoreRepository;
        this.userScoreAggregateRepository = userScoreAggregateRepository;
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

    public TriviaResponse getTrivia() throws Exception {
        List<TriviaEntity> allTrivia = triviaRepository.findAll();
        if (allTrivia.isEmpty()) {
            throw new EntityNotFoundException("Trivia not found");
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
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
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        UserEntity userEntity = userRepository.findByUserName(username);
//        UserEntity userEntity = userRepository.findByUserName(userScoreDto.getUsername());
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

    public List<AggregateScore> getAggregatedScore() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        List<AggregateScore> dummyList = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            dummyList.add(new AggregateScore(LocalDate.now().minusDays(i), 0));
        }

        List<UserScoreEntity> userScoreEntities = userScoreRepository.findAllByUsername(username);
        if (userScoreEntities == null) {
            throw new EntityNotFoundException("User scores not found");
        }
        List<BackupUserScoreEntity> backupUserScoreEntities = backupUserScoreRepository.findAllByUsername(username);
        List<ScoreDto> mergedList = new ArrayList<>();
        mergedList.addAll(userScoreEntities.stream()
                .map(entity -> new ScoreDto(entity.getSubmissionDateTime(), entity.getScore()))
                .collect(Collectors.toList()));

        mergedList.addAll(backupUserScoreEntities.stream()
                .map(entity -> new ScoreDto(entity.getSubmissionDateTime(), entity.getScore()))
                .collect(Collectors.toList()));

        List<AggregateScore> realScores = mergedList.stream()
                .collect(Collectors.groupingBy(score -> score.getSubmissionDateTime().toLocalDate(),
                        Collectors.summingInt(ScoreDto::getScore)))
                .entrySet().stream()
                .map(entry -> AggregateScore.builder()
                        .date(entry.getKey())
                        .aggregatedScore(entry.getValue())
                        .build())
                .sorted(Comparator.comparing(AggregateScore::getDate).reversed()) // Sort in descending order based on date
                .limit(5)
                .collect(Collectors.toList());

        List<AggregateScore> result = new ArrayList<>();
        Set<LocalDate> resultDates = new HashSet<>();
        int i = 0;
        int j = 0;

        while (i < 5 && j < 5 && result.size() < 5) {
            if (resultDates.contains(dummyList.get(i).getDate())) {
                i++;
            } if (resultDates.contains(realScores.get(j).getDate())) {
                j++;
            }
            if (dummyList.get(i).getDate().isEqual(realScores.get(j).getDate()) ||
                    dummyList.get(i).getDate().isBefore(realScores.get(j).getDate())) {
                result.add(realScores.get(j));
                resultDates.add(realScores.get(j).getDate());
                j++;
            } else {
                result.add(dummyList.get(i));
                resultDates.add(dummyList.get(i).getDate());
                i++;
            }
        }
        return result;
    }
}
