package org.mux.backend;

import org.mux.backend.authentication.entity.RoleEntity;
import org.mux.backend.authentication.repository.RoleRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class BackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(BackendApplication.class, args);
    }

    @Bean
    public CommandLineRunner demo(RoleRepository roleRepo) {
        return (args) -> {
            RoleEntity role=new RoleEntity();
            if (roleRepo.existsByName("ROLE_ADMIN")) {
                return;
            }
            role.setName("ROLE_ADMIN");
            roleRepo.save(role);
        };
    }
}
