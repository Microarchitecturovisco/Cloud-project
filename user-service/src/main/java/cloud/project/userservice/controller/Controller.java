package cloud.project.userservice.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class Controller {

    private final Environment environment;
    private final UUID uuid = UUID.randomUUID();

    @GetMapping("/users")
    String test() {
        String port = environment.getProperty("local.server.port");
        String uuid = this.uuid.toString();
        return "Get users test endpoint - " + port + " - " + uuid;
    }

    @GetMapping("/users/{id}")
    String getById(@PathVariable int id) {
        String port = environment.getProperty("local.server.port");
        String uuid = this.uuid.toString();
        return "Get users with " + id + " endpoint -" + port + " - " + uuid;    }
}
