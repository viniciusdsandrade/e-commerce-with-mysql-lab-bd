package com.restful.livraria.papelaria.repository;

import com.restful.livraria.papelaria.entity.Product;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository("productRepository")
@Schema(description = "Repository for managing products")
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    Page<Product> findByIsActiveTrue(Pageable pageable);

    Page<Product> findByIsActiveFalse(Pageable pageable);

    boolean existsByName(@NotBlank(message = "O name do produto é obrigatório") String name);
}
