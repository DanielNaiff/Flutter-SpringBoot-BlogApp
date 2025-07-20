package danielnaiff.backend.entities.dto;

import java.util.UUID;

public record LoginResponseDTO(String accessToken, Long expiresIn, UUID id, String username, String email) {
}
