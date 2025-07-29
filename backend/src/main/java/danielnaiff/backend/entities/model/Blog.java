package danielnaiff.backend.entities.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "tb_blogs")
public class Blog {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name="blog_id")
    private Long blogId;

    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;

    @Column(name = "image", columnDefinition = "bytea")
    private byte[] imageData;

    @Column(name="title", nullable = false)
    private String title;

    @Column(name="content", nullable = false)
    private String content;

    @ElementCollection
    private List<String> topics = new ArrayList<>();

    @CreationTimestamp
    private Instant createAt;

    @UpdateTimestamp
    private Instant updatedAt;


    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<String> getTopics() {
        return topics;
    }

    public void setTopics(List<String> topics) {
        this.topics = topics;
    }

    public Instant getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Instant createAt) {
        this.createAt = createAt;
    }

    public Instant getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Instant updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Long getBlogId() {
        return blogId;
    }

    public void setBlogId(Long blogId) {
        this.blogId = blogId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Instant getCreationTimestamp() {
        return createAt;
    }

    public void setCreationTimestamp(Instant creationTimestamp) {
        this.createAt = creationTimestamp;
    }
}
