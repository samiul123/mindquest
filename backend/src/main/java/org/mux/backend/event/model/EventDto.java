package org.mux.backend.event.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NonNull;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class EventDto {
    @NonNull
    private String title;
    @NonNull
    private String location;
    @NonNull
    private String description;
    @NonNull
    private LocalDateTime startTime;
    @NonNull
    private LocalDateTime endTime;
}
