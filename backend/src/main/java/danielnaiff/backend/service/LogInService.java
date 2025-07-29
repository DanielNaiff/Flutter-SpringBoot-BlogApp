package danielnaiff.backend.service;

import danielnaiff.backend.entities.dto.user.LoginResponseDTO;
import danielnaiff.backend.entities.dto.user.UserRequestDTO;
import danielnaiff.backend.entities.dto.user.UserResponseDTO;
import danielnaiff.backend.repository.UserRepository;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class LogInService {

    private final UserRepository userRepository;
    private final JwtEncoder jwtEncoder;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public LogInService(UserRepository userRepository, JwtEncoder jwtEncoder, BCryptPasswordEncoder bCryptPasswordEncoder){
        this.userRepository = userRepository;
        this.jwtEncoder = jwtEncoder;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    public LoginResponseDTO login(UserRequestDTO userRequestDTO){
        var userOptional = userRepository.findByEmail(userRequestDTO.email());

        if (userOptional.isEmpty()) {
            throw new BadCredentialsException("User or password is invalid!!");
        }

        var user = userOptional.get();

        if (!bCryptPasswordEncoder.matches(userRequestDTO.password(), user.getPassword())) {
            throw new BadCredentialsException("User or password is invalid!!");
        }

        var now = Instant.now();
        var expiresIn = 1000L;

        var claims = JwtClaimsSet.builder()
                .issuer("mybackend")
                .subject(user.getUserId().toString())
                .issuedAt(now)
                .expiresAt(now.plusSeconds(expiresIn))
                .build();

        var jwtValue = jwtEncoder.encode(JwtEncoderParameters.from(claims)).getTokenValue();
        var userResponse =new UserResponseDTO(user.getUserId(), user.getUserName(), user.getEmail());

        return new LoginResponseDTO(jwtValue, expiresIn, userResponse.id(), userResponse.username(), userResponse.email());
    }
}
