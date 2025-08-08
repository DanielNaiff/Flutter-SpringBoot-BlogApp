package danielnaiff.backend.controller;

import danielnaiff.backend.entities.dto.blog.BlogRequestDTO;
import danielnaiff.backend.entities.dto.blog.BlogResponseDTO;
import danielnaiff.backend.service.BlogService;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/blogs")
public class BlogController {

    private final BlogService blogService;

    public BlogController(BlogService blogService){
        this.blogService = blogService;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<BlogResponseDTO> createBlog(
            @RequestPart("blog")  BlogRequestDTO blogRequestDTO,
            @RequestPart("image") MultipartFile image
    ) throws Exception {
        // Substitui o imageData pelo conteúdo real da imagem
        blogRequestDTO = new BlogRequestDTO(
                blogRequestDTO.userId(),
                image.getBytes(), // Atualiza a imagem aqui
                blogRequestDTO.title(),
                blogRequestDTO.content(),
                blogRequestDTO.topics()
        );

        BlogResponseDTO response = blogService.createBlog(blogRequestDTO);

        return ResponseEntity
                .created(URI.create("/api/blogs/" + response.id()))
                .body(response);
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

    @PutMapping("/{id}")
    public ResponseEntity<BlogResponseDTO> update(@PathVariable Long id ,@RequestBody BlogRequestDTO requestDTO) throws Exception{
        BlogResponseDTO responseDTO = blogService.update(requestDTO, id);

        return ResponseEntity.ok(responseDTO);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Long id){
        blogService.deleteById(id);

        return ResponseEntity.ok().build();
    }
}
