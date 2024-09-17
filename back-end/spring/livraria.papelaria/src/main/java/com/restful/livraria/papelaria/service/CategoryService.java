package com.restful.livraria.papelaria.service;

import com.restful.livraria.papelaria.dto.category.DadosAtualizacaoCategoria;
import com.restful.livraria.papelaria.dto.category.DadosCadastroCategoria;
import com.restful.livraria.papelaria.dto.category.DadosDetalhamentoCategoria;
import com.restful.livraria.papelaria.entity.Category;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Schema(description = "Service for managing categories")
public interface CategoryService {

    @Transactional
    @Schema(description = "Create a new category")
    Category create(@Valid DadosCadastroCategoria dadosCadastroCategoria);

    @Schema(description = "Find a category by ID")
    Category findById(Long id);

    @Transactional
    @Schema(description = "Update an existing category")
    Category update(@Valid DadosAtualizacaoCategoria dadosAtualizacaoCategoria);

    @Schema(description = "List all categories")
    Page<DadosDetalhamentoCategoria> listCategories(Pageable pageable);

    @Schema(description = "Search categories using AND operator")
    Page<DadosDetalhamentoCategoria> searchCategoriesAnd(
            @Schema(description = "Category name to search for") String name,
            Pageable pageable
    );

    @Schema(description = "Search categories using OR operator")
    Page<DadosDetalhamentoCategoria> searchCategoriesOr(
            @Schema(description = "Category name to search for") String name,
            Pageable pageable
    );
}