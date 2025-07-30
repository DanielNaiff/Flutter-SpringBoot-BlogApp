package danielnaiff.backend.service;

import danielnaiff.backend.entities.dto.blog.BlogRequestDTO;
import danielnaiff.backend.entities.dto.blog.BlogResponseDTO;
import danielnaiff.backend.entities.model.Blog;
import danielnaiff.backend.entities.model.User;
import danielnaiff.backend.mapper.BlogMapper;
import danielnaiff.backend.repository.BlogRepository;
import danielnaiff.backend.repository.UserRepository;
import org.springframework.expression.ExpressionException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BlogService {

    private final BlogRepository blogRepository;
    private final UserRepository userRepository;

    public BlogService(BlogRepository blogRepository, UserRepository userRepository){
        this.blogRepository = blogRepository;
        this.userRepository = userRepository;
    }

    public BlogResponseDTO createBlog(BlogRequestDTO blogRequestDTO) throws Exception {

        User user = userRepository.findById(blogRequestDTO.userId())
                .orElseThrow(() -> new Exception("Usuário não encontrado"));

        Blog blog = BlogMapper.toEntity(blogRequestDTO, user);

        Blog savedBlog = blogRepository.save(blog);

        BlogResponseDTO blogResponseDTO = BlogMapper.toResponseDTO(savedBlog);
        return blogResponseDTO;
    }

    public BlogResponseDTO findById(Long id) throws Exception{
        Blog blog = blogRepository.findById(id).orElseThrow(() -> new Exception("Usuário não encontrado"));

        return BlogMapper.toResponseDTO(blog);
    }

    public List<BlogResponseDTO> findAll(){
        List<Blog> blogs = blogRepository.findAll();

        return blogs.stream().map(BlogMapper::toResponseDTO).collect(Collectors.toList());
    }
}
