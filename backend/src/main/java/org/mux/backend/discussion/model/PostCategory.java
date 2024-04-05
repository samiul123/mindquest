package org.mux.backend.discussion.model;

import lombok.Getter;

@Getter
public enum PostCategory {
    VENTING("Venting"),
    QUESTIONING("Questioning"),
    SUPPORT("Support");

    final String value;

    PostCategory(String value) {
        this.value = value;
    }
}
