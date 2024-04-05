package org.mux.backend.discussion.model;

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
public class PostDto {
    private Integer id;

    private String subject;

    private String body;

    private String postCategory;

    private String username;

    private LocalDateTime createdAt;
}
