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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        UserEntity userEntity = userRepository.findByUserName(username);
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

    public Page<PostDto> getPosts(int pageNo) {
        Pageable pageable = PageRequest.of(pageNo, 15, Sort.by("createdAt").descending());
        return discussionRepo.findAll(pageable)
                .map(postEntity -> PostDto.builder()
                        .id(postEntity.getId())
                        .subject(postEntity.getSubject())
                        .body(postEntity.getBody())
                        .postCategory(postEntity.getPostCategory())
                        .username(postEntity.getUserEntity().getUserName())
                        .createdAt(postEntity.getCreatedAt()).build());
    }

    public void createComment(CommentDto commentDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        UserEntity userEntity = userRepository.findByUserName(username);
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

    public Page<CommentDto> getComments(int postId, int pageNo) {
        Pageable pageable = PageRequest.of(pageNo, 15, Sort.by("createdAt").descending());
        Page<CommentEntity> comments = commentRepository.findByPostId(postId, pageable);
        if (comments == null) {
            throw new EntityNotFoundException("Comments for postId " + postId + " not found");
        }
        return comments.map(comment ->
                CommentDto.builder()
                        .id(comment.getId())
                        .body(comment.getBody())
                        .createdAt(comment.getCreatedAt())
                        .postId(comment.getPost().getId())
                        .username(comment.getUserEntity().getUserName())
                        .build()
        );
    }
}
