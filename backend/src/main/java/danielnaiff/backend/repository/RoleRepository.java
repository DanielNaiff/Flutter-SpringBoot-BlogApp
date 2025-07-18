package danielnaiff.backend.repository;

import danielnaiff.backend.entities.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {
}
