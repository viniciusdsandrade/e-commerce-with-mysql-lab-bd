package com.restful.livraria.papelaria.service;

import com.restful.livraria.papelaria.dto.product.DadosAtualizacaoProduto;
import com.restful.livraria.papelaria.dto.product.DadosCadastroProduto;
import com.restful.livraria.papelaria.dto.product.DadosDetalhamentoProduto;
import com.restful.livraria.papelaria.entity.Product;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.List;

@Schema(description = "Service for managing products")
public interface ProductService {

    @Transactional
    @Schema(description = "Create a new product")
    Product create(@Valid DadosCadastroProduto product);

    @Schema(description = "Find a product by ID")
    Product findById(Long id);

    @Transactional
    @Schema(description = "Update an existing product")
    Product update(@Valid DadosAtualizacaoProduto dadosAtualizacaoProduto);

    @Transactional
    @Schema(description = "Block a product")
    void lockProduct(Long id);

    @Transactional
    @Schema(description = "Unlock a product")
    void unlockProduct(Long id);

    @Schema(description = "List all products")
    Page<DadosDetalhamentoProduto> listProducts(Pageable pageable);

    @Schema(description = "List available products")
    Page<DadosDetalhamentoProduto> availableProducts(Pageable pageable);

    @Schema(description = "List unavailable products")
    Page<DadosDetalhamentoProduto> unavailableProducts(Pageable pageable);

    @Schema(description = "Search products using AND operator")
    Page<DadosDetalhamentoProduto> searchProductsAnd(
            @Schema(description = "Product name to search for") String name,
            @Schema(description = "Product description to search for") String description,
            @Schema(description = "Minimum product price") BigDecimal minPrice,
            @Schema(description = "Maximum product price") BigDecimal maxPrice,
            @Schema(description = "Product availability status (true for available, false for unavailable)") boolean isActive,
            @Schema(description = "List of category names to filter by") List<String> categoriesNames,
            Pageable pageable
    );

    @Schema(description = "Search products using OR operator")
    Page<DadosDetalhamentoProduto> searchProductsOr(
            @Schema(description = "Product name to search for") String name,
            @Schema(description = "Product description to search for") String description,
            @Schema(description = "Minimum product price") BigDecimal minPrice,
            @Schema(description = "Maximum product price") BigDecimal maxPrice,
            @Schema(description = "Product availability status (true for available, false for unavailable)") boolean isActive,
            @Schema(description = "List of category names to filter by") List<String> categoriesNames,
            Pageable pageable
    );
}