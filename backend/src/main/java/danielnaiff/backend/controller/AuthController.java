package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.LoginResponseDTO;
import danielnaiff.backend.entities.dto.UserRequestDTO;
import danielnaiff.backend.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService){
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody UserRequestDTO userRequestDTO) {
        LoginResponseDTO response = authService.login(userRequestDTO);

        return ResponseEntity.ok(response);
    }
}
