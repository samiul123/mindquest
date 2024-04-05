package org.mux.backend.discussion.service;

import jakarta.persistence.EntityNotFoundException;
import org.mux.backend.authentication.entity.UserEntity;
import org.mux.backend.authentication.repository.UserRepository;
import org.mux.backend.discussion.entity.CommentEntity;
import org.mux.backend.discussion.entity.PostEntity;
import org.mux.backend.discussion.model.CommentDto;
import org.mux.backend.discussion.model.PostCategory;
import org.mux.backend.discussion.model.PostDto;
import org.mux.backend.discussion.repository.CommentRepository;
import org.mux.backend.discussion.repository.DiscussionRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class DiscussionService {

    private final DiscussionRepository discussionRepo;
    private final UserRepository userRepository;
    private final CommentRepository commentRepository;

    public DiscussionService(DiscussionRepository discussionRepo,
                             UserRepository userRepository,
                             CommentRepository commentRepository) {
        this.discussionRepo = discussionRepo;
        this.userRepository = userRepository;
        this.commentRepository = commentRepository;
    }

    public void createPost(PostDto postDto) {
        UserEntity userEntity = userRepository.findByUserName(postDto.getUsername());
        if (userEntity == null) {
            throw new EntityNotFoundException("Username " + postDto.getUsername() + " not found");
        }

        discussionRepo.save(PostEntity.builder()
                .subject(postDto.getSubject())
                .body(postDto.getBody())
                .postCategory(PostCategory.valueOf(postDto.getPostCategory()).getValue())
                .userEntity(userEntity)
                .createdAt(LocalDateTime.now())
                .build());
    }

    public List<PostDto> getPosts() {
        return discussionRepo.findAll()
                .stream()
                .map(postEntity -> PostDto.builder()
                        .id(postEntity.getId())
                        .subject(postEntity.getSubject())
                        .body(postEntity.getBody())
                        .postCategory(postEntity.getPostCategory())
                        .username(postEntity.getUserEntity().getUserName())
                        .createdAt(postEntity.getCreatedAt()).build())
                .collect(Collectors.toList());
    }

    public void createComment(CommentDto commentDto) {
        UserEntity userEntity = userRepository.findByUserName(commentDto.getUsername());
        if (userEntity == null) {
            throw new EntityNotFoundException("Username " + commentDto.getUsername() + " not found");
        }

        Optional<PostEntity> postEntity = Optional.ofNullable(discussionRepo.findById(commentDto.getPostId())
                .orElseThrow(() -> new EntityNotFoundException("Post id " + commentDto.getPostId() + "not found")));

        commentRepository.save(CommentEntity.builder()
                .body(commentDto.getBody())
                .userEntity(userEntity)
                .post(postEntity.get())
                .createdAt(LocalDateTime.now())
                .build());
    }

    public List<CommentDto> getComments(Integer postId) {
        List<CommentEntity> comments = commentRepository.findByPostId(postId);
        if (comments == null) {
            throw new EntityNotFoundException("Comments for postId " + postId + " not found");
        }
        return comments.stream().map(comment ->
                CommentDto.builder()
                        .id(comment.getId())
                        .body(comment.getBody())
                        .createdAt(comment.getCreatedAt())
                        .postId(comment.getPost().getId())
                        .username(comment.getUserEntity().getUserName())
                        .build()
        ).collect(Collectors.toList());
    }
}
