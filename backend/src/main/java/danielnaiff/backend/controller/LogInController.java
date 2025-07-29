package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.user.LoginResponseDTO;
import danielnaiff.backend.entities.dto.user.UserRequestDTO;
import danielnaiff.backend.service.LogInService;
import jakarta.transaction.Transactional;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LogInController {

    private final LogInService authService;

    public LogInController(LogInService authService){
        this.authService = authService;
    }

    @Transactional
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody UserRequestDTO userRequestDTO) {
        LoginResponseDTO response = authService.login(userRequestDTO);

        return ResponseEntity.ok(response);
    }
}
