package org.mux.backend.event.controller;

import org.mux.backend.event.model.EventDto;
import org.mux.backend.event.service.EventService;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class EventController {
    private EventService eventService;

    public EventController(EventService eventService) {
        this.eventService = eventService;
    }

    @PostMapping("/events")
    public ResponseEntity<String> postEvents(@RequestBody(required = true) EventDto eventDto) {
        eventService.createEvent(eventDto);
        return new ResponseEntity<>("Event created", HttpStatus.OK);
    }

    @GetMapping("/events/{period}")
    public ResponseEntity<List<EventDto>> getEvents(@PathVariable String period) {
        return new ResponseEntity<>(eventService.getEvents(period), HttpStatus.OK);
    }

}
