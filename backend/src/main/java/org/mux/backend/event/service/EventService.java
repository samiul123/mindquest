package org.mux.backend.event.service;

import org.mux.backend.event.entity.EventEntity;
import org.mux.backend.event.model.EventDto;
import org.mux.backend.event.repository.EventRepository;
import org.springframework.stereotype.Service;

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
                .startTime(eventDto.getStartTime())
                .endTime(eventDto.getEndTime())
                .location(eventDto.getLocation())
                .description(eventDto.getDescription())
                .build());
    }

    public List<EventDto> getEvents(String period) {
        if (period.equals("current-week")) {
            return eventRepository.findEventsForCurrentWeek()
                    .stream()
                    .map(eventEntity -> EventDto.builder()
                            .title(eventEntity.getTitle())
                            .description(eventEntity.getDescription())
                            .location(eventEntity.getLocation())
                            .startTime(eventEntity.getStartTime())
                            .endTime(eventEntity.getEndTime())
                            .build())
                    .collect(Collectors.toList());
        }
        return null;
    }
}
