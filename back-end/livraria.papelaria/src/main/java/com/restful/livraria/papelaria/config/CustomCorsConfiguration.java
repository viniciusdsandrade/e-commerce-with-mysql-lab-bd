package com.restful.livraria.papelaria.config;

import io.swagger.v3.oas.annotations.media.Schema;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;


import static java.util.Arrays.asList;

/**
 * Configura o CORS (Cross-Origin Resource Sharing) para a aplicação.
 * <p>
 * Permite requisições de origens específicas, como "<a href="http://localhost:3000">...</a>" e "<a href="http://localhost:8080">...</a>",
 * com métodos HTTP específicos (GET, POST, PUT, DELETE, OPTIONS), headers e credenciais.
 *
 * @see CorsConfiguration
 * @see UrlBasedCorsConfigurationSource
 * @see CorsFilter
 */
@Configuration("CustomCorsConfiguration")
@Schema(description = "Configuração global do CORS para a aplicação.")
public class CustomCorsConfiguration {

    /**
     * Cria um bean `CorsFilter` com as configurações de CORS definidas.
     *
     * @return Um novo filtro CORS com as configurações especificadas.
     */
    @Bean("corsFilter")
    @Schema(description = "Cria e configura o filtro CORS.")
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(asList("http://localhost:3000", "http://localhost:8080"));
        config.setAllowedHeaders(asList("Origin", "Content-Type", "Accept"));
        config.setAllowedMethods(asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);

        return new CorsFilter(source);
    }
}
