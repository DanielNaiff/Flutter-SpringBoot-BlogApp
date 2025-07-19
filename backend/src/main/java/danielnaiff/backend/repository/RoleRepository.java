package danielnaiff.backend.repository;

import danielnaiff.backend.entities.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByName (String name);
}
