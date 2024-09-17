package com.restful.livraria.papelaria.controller;

import com.restful.livraria.papelaria.dto.category.DadosAtualizacaoCategoria;
import com.restful.livraria.papelaria.dto.category.DadosCadastroCategoria;
import com.restful.livraria.papelaria.dto.category.DadosDetalhamentoCategoria;
import com.restful.livraria.papelaria.entity.Category;
import com.restful.livraria.papelaria.service.CategoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;

import static org.springframework.data.domain.PageRequest.of;
import static org.springframework.data.domain.Sort.by;
import static org.springframework.http.ResponseEntity.*;

@RestController
@RequestMapping("/api/v1/categories")
@CrossOrigin(origins = "*", allowedHeaders = "*")
@Tag(name = "Category Controller", description = "Controller para gerenciamento de categorias")
public class CategoryController {

    @Schema(description = "Controller para gerenciamento de categorias.")
    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @Transactional
    @PostMapping
    @Operation(summary = "Cadastrar uma nova categoria")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Categoria criada com sucesso."),
            @ApiResponse(responseCode = "400", description = "Dados de cadastro inválidos.")
    })
    public ResponseEntity<DadosDetalhamentoCategoria> cadastrar(
            @RequestBody @Valid DadosCadastroCategoria dadosCadastroCategoria,
            UriComponentsBuilder uriBuilder
    ) {
        Category category = categoryService.create(dadosCadastroCategoria);
        URI uri = uriBuilder.path("/api/v1/categories/{id}").buildAndExpand(category.getId()).toUri();
        return created(uri).body(new DadosDetalhamentoCategoria(category));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Detalhar uma categoria")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Categoria encontrada."),
            @ApiResponse(responseCode = "404", description = "Categoria não encontrada.")
    })
    public ResponseEntity<DadosDetalhamentoCategoria> detalhar(@PathVariable Long id) {
        Category category = categoryService.findById(id);
        return ok(new DadosDetalhamentoCategoria(category));
    }

    @GetMapping("/all")
    @Operation(summary = "Listar categorias", description = "Retorna uma lista paginada de categorias.")
    @ApiResponse(responseCode = "200", description = "Lista de categorias.")
    public ResponseEntity<Page<DadosDetalhamentoCategoria>> listarTodos(
            @RequestParam(value = "page", required = false, defaultValue = "0") int page,
            @RequestParam(value = "size", required = false, defaultValue = "5") int size,
            @RequestParam(value = "limit", required = false) Integer limit,
            @RequestParam(value = "offset", required = false) Integer offset,
            @RequestParam(value = "sort", required = false, defaultValue = "id") String sort
    ) {

        if (limit != null && offset != null) {
            page = offset / limit;
            size = limit;
        }

        Pageable paginacao = of(page, size, by(sort));
        Page<DadosDetalhamentoCategoria> categories = categoryService.listCategories(paginacao);
        return ok(categories);
    }

    @Transactional
    @PatchMapping
    @Operation(summary = "Atualizar uma categoria", description = "Atualiza parte ou todos os dados de uma categoria.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Categoria atualizada com sucesso."),
            @ApiResponse(responseCode = "400", description = "Dados de atualização inválidos."),
            @ApiResponse(responseCode = "404", description = "Categoria não encontrada.")
    })
    public ResponseEntity<DadosDetalhamentoCategoria> atualizar(@RequestBody @Valid DadosAtualizacaoCategoria dadosAtualizacaoCategoria) {
        Category category = categoryService.update(dadosAtualizacaoCategoria);
        return ok(new DadosDetalhamentoCategoria(category));
    }

    @GetMapping("/search-and")
    @Operation(summary = "Pesquisar categorias por critérios (AND)",
            description = "Retorna uma lista paginada de categorias que correspondem a todos os critérios de pesquisa (AND).")
    @ApiResponse(responseCode = "200", description = "Lista de categorias encontradas.")
    public ResponseEntity<Page<DadosDetalhamentoCategoria>> pesquisarCategoriasAnd(
            @RequestParam(required = false) String name,
            @RequestParam(value = "page", required = false, defaultValue = "0") int page,
            @RequestParam(value = "size", required = false, defaultValue = "5") int size,
            @RequestParam(value = "limit", required = false) Integer limit,
            @RequestParam(value = "offset", required = false) Integer offset,
            @RequestParam(value = "sort", required = false, defaultValue = "id") String sort
    ) {

        if (limit != null && offset != null) {
            page = offset / limit;
            size = limit;
        }

        Pageable paginacao = of(page, size, by(sort));
        Page<DadosDetalhamentoCategoria> categories = categoryService.searchCategoriesAnd(
                name,
                paginacao
        );

        return ok(categories);
    }

    @GetMapping("/search-or")
    @Operation(summary = "Pesquisar categorias por critérios (OR)",
            description = "Retorna uma lista paginada de categorias que correspondem a pelo menos um dos critérios de pesquisa (OR).")
    @ApiResponse(responseCode = "200", description = "Lista de categorias encontradas.")
    public ResponseEntity<Page<DadosDetalhamentoCategoria>> pesquisarCategoriasOr(
            @RequestParam(required = false) String name,
            @RequestParam(value = "page", required = false, defaultValue = "0") int page,
            @RequestParam(value = "size", required = false, defaultValue = "5") int size,
            @RequestParam(value = "limit", required = false) Integer limit,
            @RequestParam(value = "offset", required = false) Integer offset,
            @RequestParam(value = "sort", required = false, defaultValue = "id") String sort
    ) {

        if (limit != null && offset != null) {
            page = offset / limit;
            size = limit;
        }

        Pageable paginacao = of(page, size, by(sort));
        Page<DadosDetalhamentoCategoria> categories = categoryService.searchCategoriesOr(
                name,
                paginacao
        );

        return ok(categories);
    }
}