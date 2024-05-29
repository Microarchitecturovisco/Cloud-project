package cloud.project.travelservice.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class Controller {

    private final Environment environment;

    @GetMapping("/travels")
    String test() {
        return "Get travels test endpoint - " + environment.getProperty("local.server.port");
    }

    @GetMapping("/travels/{id}")
    String getById(@PathVariable int id) {
        return "Get travel with " + id + " endpoint - " + environment.getProperty("local.server.port");
    }
}
