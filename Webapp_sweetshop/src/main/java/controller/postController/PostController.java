//package controller.postController;
//
//import jakarta.servlet.http.HttpServlet;
//
//@RestController
//@RequestMapping("/posts")
//public class PostController {
//
//    @Autowired
//    private PostService postService;
//
//    // Create Post
//    @PostMapping
//    public ResponseEntity<Post> createPost(@RequestBody Post post) {
//        Post createdPost = postService.createPost(post);
//        return new ResponseEntity<>(createdPost, HttpStatus.CREATED);
//    }
//
//    // Update Post
//    @PutMapping("/{id}")
//    public ResponseEntity<Post> updatePost(@PathVariable Long id, @RequestBody Post post) {
//        Post updatedPost = postService.updatePost(id, post);
//        return ResponseEntity.ok(updatedPost);
//    }
//
//    // View Post
//    @GetMapping("/{id}")
//    public ResponseEntity<Post> getPost(@PathVariable Long id) {
//        Post post = postService.getPostById(id);
//        return ResponseEntity.ok(post);
//    }
//
//    // List Posts
//    @GetMapping
//    public ResponseEntity<List<Post>> listPosts() {
//        List<Post> posts = postService.getAllPosts();
//        return ResponseEntity.ok(posts);
//    }
//}
//
