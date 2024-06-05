package cloud.project.travelservice.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class Controller {

    private final Environment environment;
    private final UUID uuid = UUID.randomUUID();

    @GetMapping("/travels")
    String test() {
        String port = environment.getProperty("local.server.port");
        String uuid = this.uuid.toString();
        return "Get travels test endpoint - " + port + " - " + uuid;
    }

    @GetMapping("/travels/{id}")
    String getById(@PathVariable int id) {
        String port = environment.getProperty("local.server.port");
        String uuid = this.uuid.toString();
        return "Get travels with " + id + " endpoint -" + port + " - " + uuid;
    }
}
