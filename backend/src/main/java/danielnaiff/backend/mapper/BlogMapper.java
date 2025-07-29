package danielnaiff.backend.mapper;

import danielnaiff.backend.entities.dto.blog.BlogRequestDTO;
import danielnaiff.backend.entities.dto.blog.BlogResponseDTO;
import danielnaiff.backend.entities.model.Blog;
import danielnaiff.backend.entities.model.User;

import java.time.Instant;
import java.time.LocalDateTime;

public class BlogMapper {

    public static Blog toEntity(BlogRequestDTO dto, User user) {
        Blog blog = new Blog();
        blog.setTitle(dto.title());
        blog.setContent(dto.content());
        blog.setUser(user);
        blog.setTopics(dto.topics());
        blog.setImageData(dto.imageData());
        blog.setCreateAt(Instant.now());
        blog.setUpdatedAt(Instant.now());

        return blog;
    }

    public static BlogResponseDTO toResponseDTO(Blog blog) {
        BlogResponseDTO dto = new BlogResponseDTO(blog.getBlogId(),blog.getUser().getUserId(), blog.getImageData(), blog.getContent(), blog.getTitle(), blog.getTopics());
        return dto;
    }
}