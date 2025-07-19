package danielnaiff.backend.service;

import danielnaiff.backend.entities.dto.UserRequestDTO;
import danielnaiff.backend.entities.model.Role;
import danielnaiff.backend.entities.model.User;
import danielnaiff.backend.repository.RoleRepository;
import danielnaiff.backend.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Set;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    public User createUser(UserRequestDTO userRequestDTO){
      var basiRole = roleRepository.findByName(Role.Values.BASIC.name());
      var userFromDb = userRepository.findByEmail(userRequestDTO.email());

      if(userFromDb.isPresent()){
          throw new ResponseStatusException(HttpStatus.UNPROCESSABLE_ENTITY);
      }

      var user = new User();
      user.setUserName(userRequestDTO.username());
      user.setEmail(userRequestDTO.email());
      user.setPassword(bCryptPasswordEncoder.encode(userRequestDTO.password()));
      user.setRoles(Set.of(basiRole));

     return userRepository.save(user);

    }
}
