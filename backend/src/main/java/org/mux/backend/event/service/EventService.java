package org.mux.backend.event.service;

import org.mux.backend.event.entity.EventEntity;
import org.mux.backend.event.model.EventDto;
import org.mux.backend.event.repository.EventRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class EventService {
    private final EventRepository eventRepository;

    public EventService(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    public void createEvent(EventDto eventDto) {
        eventRepository.save(EventEntity.builder()
                .title(eventDto.getTitle())
                .dateTime(LocalDateTime.now())
                .location(eventDto.getLocation())
                .description(eventDto.getDescription())
                .build());
    }

    public List<EventDto> getEvents(String period) {
        if (period.equals("current-week")) {
            return eventRepository.findEventsForCurrentWeek(2)
                    .stream()
                    .map(eventEntity -> EventDto.builder()
                            .title(eventEntity.getTitle())
                            .description(eventEntity.getDescription())
                            .location(eventEntity.getLocation())
                            .dateTime(eventEntity.getDateTime())
                            .build())
                    .collect(Collectors.toList());
        }
        return null;
    }
}