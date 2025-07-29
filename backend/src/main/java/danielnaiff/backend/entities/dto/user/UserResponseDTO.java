package danielnaiff.backend.entities.dto.user;

import java.util.UUID;

public record UserResponseDTO(UUID id, String username, String email)  {
}
