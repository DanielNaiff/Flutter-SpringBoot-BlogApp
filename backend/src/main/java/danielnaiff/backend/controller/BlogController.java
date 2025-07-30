package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.blog.BlogRequestDTO;
import danielnaiff.backend.entities.dto.blog.BlogResponseDTO;
import danielnaiff.backend.service.BlogService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/blogs")
public class BlogController {

    private final BlogService blogService;

    public BlogController(BlogService blogService){
        this.blogService = blogService;
    }

    @PostMapping
    public ResponseEntity<BlogResponseDTO> createBlog(@RequestBody BlogRequestDTO blogRequestDTO) throws Exception {
        BlogResponseDTO blogResponseDTO = blogService.createBlog(blogRequestDTO);
        return ResponseEntity
                .created(URI.create("/api/blogs/" + blogResponseDTO.id()))
                .body(blogResponseDTO);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BlogResponseDTO> findById(@PathVariable Long id) throws Exception{
        BlogResponseDTO blogResponseDTO = blogService.findById(id);
        return ResponseEntity.ok(blogResponseDTO);
    }

    @GetMapping
    public ResponseEntity<List<BlogResponseDTO>> findId(){
        List<BlogResponseDTO> blogResponseDTOS = blogService.findAll();
        if(blogResponseDTOS.isEmpty()){
            return ResponseEntity.status(500).build();
        }

        return ResponseEntity.ok(blogResponseDTOS);
    }
}
