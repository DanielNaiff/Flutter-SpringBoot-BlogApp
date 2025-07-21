package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.UserRequestDTO;
import danielnaiff.backend.entities.dto.UserResponseDTO;
import danielnaiff.backend.service.UserService;
import jakarta.transaction.Transactional;
import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @Transactional
    @PostMapping("/users")
    public ResponseEntity<UserResponseDTO> createUser(@RequestBody UserRequestDTO userRequestDTO){
        var user = userService.createUser(userRequestDTO);
        var response = new UserResponseDTO(user.getUserId(), user.getUserName(), user.getEmail());
        System.out.println("Usuário criado: " + user.getUserName());
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponseDTO> getCurrentUser(Authentication authentication){
        if(authentication == null || !authentication.isAuthenticated()){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        UUID userId = UUID.fromString(authentication.getName());
        var user = userService.findById(userId);
        if(user == null){
            return ResponseEntity.notFound().build();

        }

        var response = new UserResponseDTO(user.getUserId(), user.getUserName(), user.getEmail());
        return ResponseEntity.ok(response);
    }
}
