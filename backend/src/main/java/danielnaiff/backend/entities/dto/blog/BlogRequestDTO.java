package danielnaiff.backend.entities.dto.blog;

import danielnaiff.backend.entities.model.User;

import java.util.List;
import java.util.UUID;

public record BlogRequestDTO(
        UUID userId,
        byte[] imageData,
        String title,
        String content,
        List<String> topics
) {
}
