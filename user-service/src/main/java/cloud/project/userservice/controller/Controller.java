package cloud.project.userservice.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class Controller {

    private final Environment environment;

    @GetMapping("/users")
    String test() {
        return "Get users test endpoint - " + environment.getProperty("local.server.port");
    }

    @GetMapping("/users/{id}")
    String getById(@PathVariable int id) {
        return "Get user with " + id + " endpoint - " + environment.getProperty("local.server.port");
    }
}
