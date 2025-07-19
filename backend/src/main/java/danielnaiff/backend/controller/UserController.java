package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.UserRequestDTO;
import danielnaiff.backend.entities.dto.UserResponseDTO;
import danielnaiff.backend.service.UserService;
import jakarta.transaction.Transactional;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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
}
