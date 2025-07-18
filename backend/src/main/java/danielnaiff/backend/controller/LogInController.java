package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.LoginResponseDTO;
import danielnaiff.backend.entities.dto.UserRequestDTO;
import danielnaiff.backend.service.LogInService;
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

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody UserRequestDTO userRequestDTO) {
        LoginResponseDTO response = authService.login(userRequestDTO);

        return ResponseEntity.ok(response);
    }
}
