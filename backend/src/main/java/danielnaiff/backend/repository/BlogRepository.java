package danielnaiff.backend.repository;

import danielnaiff.backend.entities.model.Blog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BlogRepository extends JpaRepository<Blog,Long> {
}
