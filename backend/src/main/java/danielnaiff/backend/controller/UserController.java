package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.UserRequestDTO;
import danielnaiff.backend.service.UserService;
import jakarta.transaction.Transactional;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<Void> createUser(@RequestBody UserRequestDTO userRequestDTO){
        userService.createUser(userRequestDTO);
        return ResponseEntity.ok().build();
    }
}
