package com.restful.livraria.papelaria.controller;

import com.restful.livraria.papelaria.dto.product.DadosAtualizacaoProduto;
import com.restful.livraria.papelaria.dto.product.DadosCadastroProduto;
import com.restful.livraria.papelaria.dto.product.DadosDetalhamentoProduto;
import com.restful.livraria.papelaria.entity.Product;
import com.restful.livraria.papelaria.service.ProductService;
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

import java.math.BigDecimal;
import java.net.URI;
import java.util.List;

import static org.springframework.data.domain.PageRequest.of;
import static org.springframework.data.domain.Sort.by;
import static org.springframework.http.ResponseEntity.*;

@RestController
@RequestMapping("/api/v1/products")
@CrossOrigin(origins = "*", allowedHeaders = "*")
@Tag(name = "Product Controller", description = "Controller para gerenciamento de produtos")
public class ProductController {

    @Schema(description = "Controller para gerenciamento de produtos.")
    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @Transactional
    @PostMapping
    @Operation(summary = "Cadastrar um novo produto")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Produto criado com sucesso."),
            @ApiResponse(responseCode = "400", description = "Dados de cadastro inválidos.")
    })
    public ResponseEntity<DadosDetalhamentoProduto> cadastrar(
            @RequestBody @Valid DadosCadastroProduto dadosCadastroProduto,
            UriComponentsBuilder uriBuilder
    ) {
        Product product = productService.create(dadosCadastroProduto);
        URI uri = uriBuilder.path("/api/v1/products/{id}").buildAndExpand(product.getId()).toUri();
        return created(uri).body(new DadosDetalhamentoProduto(product));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Detalhar um produto")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Produto encontrado."),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado.")
    })
    public ResponseEntity<DadosDetalhamentoProduto> detalhar(@PathVariable Long id) {
        Product product = productService.findById(id);
        return ok(new DadosDetalhamentoProduto(product));
    }

    @GetMapping("/all")
    @Operation(summary = "Listar produtos", description = "Retorna uma lista paginada de produtos.")
    @ApiResponse(responseCode = "200", description = "Lista de produtos.")
    public ResponseEntity<Page<DadosDetalhamentoProduto>> listarTodos(
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
        Page<DadosDetalhamentoProduto> products = productService.listProducts(paginacao);
        return ok(products);
    }

    @GetMapping("/available")
    @Operation(summary = "Listar produtos disponíveis",
            description = "Retorna uma lista paginada de produtos disponíveis.")
    @ApiResponse(responseCode = "200", description = "Lista de produtos disponíveis.")
    public ResponseEntity<Page<DadosDetalhamentoProduto>> listarProdutosDisponiveis(
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
        Page<DadosDetalhamentoProduto> products = productService.availableProducts(paginacao);
        return ok(products);
    }

    @GetMapping("/unavailable")
    @Operation(summary = "Listar produtos indisponíveis",
            description = "Retorna uma lista paginada de produtos indisponíveis.")
    @ApiResponse(responseCode = "200", description = "Lista de produtos indisponíveis.")
    public ResponseEntity<Page<DadosDetalhamentoProduto>> listarProdutosIndisponiveis(
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
        Page<DadosDetalhamentoProduto> products = productService.unavailableProducts(paginacao);

        return ok(products);
    }

    @Transactional
    @PatchMapping
    @Operation(summary = "Atualizar um produto", description = "Atualiza parte ou todos os dados de um produto.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Produto atualizado com sucesso."),
            @ApiResponse(responseCode = "400", description = "Dados de atualização inválidos."),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado.")
    })
    public ResponseEntity<DadosDetalhamentoProduto> atualizar(@RequestBody @Valid DadosAtualizacaoProduto dadosAtualizacaoProduto) {
        Product product = productService.update(dadosAtualizacaoProduto);
        return ok(new DadosDetalhamentoProduto(product));
    }

    @PatchMapping("/{id}/lock")
    @Operation(summary = "Bloquear um produto", description = "Bloqueia um produto para que ele não possa ser vendido.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Produto bloqueado com sucesso."),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado.")
    })
    public ResponseEntity<Void> bloquearProduto(@PathVariable Long id) {
        productService.lockProduct(id);
        return noContent().build();
    }

    @PatchMapping("/{id}/unlock")
    @Operation(summary = "Desbloquear um produto", description = "Desbloqueia um produto para que ele possa ser vendido.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Produto desbloqueado com sucesso."),
            @ApiResponse(responseCode = "404", description = "Produto não encontrado.")
    })
    public ResponseEntity<Void> desbloquearProduto(@PathVariable Long id) {
        productService.unlockProduct(id);
        return noContent().build();
    }

    @GetMapping("/search-and")
    @Operation(summary = "Pesquisar produtos por critérios (AND)",
            description = "Retorna uma lista paginada de produtos que correspondem a todos os critérios de pesquisa (AND).")
    @ApiResponse(responseCode = "200", description = "Lista de produtos encontrados.")
    public ResponseEntity<Page<DadosDetalhamentoProduto>> pesquisarProdutosAnd(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) Boolean isActive,
            @RequestParam(required = false) List<String> categoriesNames,
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
        Page<DadosDetalhamentoProduto> products = productService.searchProductsAnd(
                name,
                description,
                minPrice,
                maxPrice,
                isActive,
                categoriesNames,
                paginacao
        );

        return ok(products);
    }

    @GetMapping("/search-or")
    @Operation(summary = "Pesquisar produtos por critérios (OR)",
            description = "Retorna uma lista paginada de produtos que correspondem a pelo menos um dos critérios de pesquisa (OR).")
    @ApiResponse(responseCode = "200", description = "Lista de produtos encontrados.")
    public ResponseEntity<Page<DadosDetalhamentoProduto>> pesquisarProdutosOr(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) Boolean isActive,
            @RequestParam(required = false) List<String> categoriesNames,
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
        Page<DadosDetalhamentoProduto> products = productService.searchProductsOr(
                name,
                description,
                minPrice,
                maxPrice,
                isActive,
                categoriesNames,
                paginacao
        );

        return ok(products);
    }
}