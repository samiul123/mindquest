package org.mux.backend.discussion.controller;

import org.mux.backend.discussion.model.CommentDto;
import org.mux.backend.discussion.model.PostDto;
import org.mux.backend.discussion.service.DiscussionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class DiscussionController {

    private final DiscussionService discussionService;

    public DiscussionController(DiscussionService discussionService) {
        this.discussionService = discussionService;
    }

    @PostMapping("/posts")
    public ResponseEntity<String> createPost(@RequestBody PostDto post) {
        discussionService.createPost(post);
        return ResponseEntity.ok("Post created");
    }

    @GetMapping("/posts")
    public ResponseEntity<List<PostDto>> getPosts() {
        List<PostDto> posts = discussionService.getPosts();
        return ResponseEntity.ok(posts);
    }

    @PostMapping("/comments")
    public ResponseEntity<String> createComment(@RequestBody CommentDto commentDto) {
        discussionService.createComment(commentDto);
        return ResponseEntity.ok("Comment created");
    }

    @GetMapping("/comments")
    public ResponseEntity<List<CommentDto>> getComment(@RequestParam Integer postId) {
        List<CommentDto> comments = discussionService.getComments(postId);
        return ResponseEntity.ok(comments);
    }
}
