package danielnaiff.backend.config;

import danielnaiff.backend.entities.model.User;
import danielnaiff.backend.entities.model.Role;
import danielnaiff.backend.repository.RoleRepository;
import danielnaiff.backend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Set;

@Configuration
public class UserConfig implements CommandLineRunner {
    private RoleRepository roleRepository;
    private UserRepository userRepository;
    private BCryptPasswordEncoder passwordEncoder;

    public UserConfig(RoleRepository roleRepository, UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(String... args) throws Exception{
        var roleUser = roleRepository.findByName(Role.Values.BASIC.name());

        if (roleUser == null) {
            roleUser = new Role();
            roleUser.setName(Role.Values.BASIC.name());
            roleUser = roleRepository.save(roleUser);
        }

//        var userBasic = userRepository.findByUserName("BASIC");

        var userBasic = userRepository.findByUserName("BASIC");

        final Role finalRoleUser = roleUser;

        userBasic.ifPresentOrElse(
                user -> {
                    System.out.println("usuario ja existe");
                    },
                () -> {
                    var user = new User();
                    user.setUsername("BASIC");
                    user.setPassword(passwordEncoder.encode("123"));
                    user.setRoles(Set.of(finalRoleUser));
                    userRepository.save(user);
                }
                );
    }
}
