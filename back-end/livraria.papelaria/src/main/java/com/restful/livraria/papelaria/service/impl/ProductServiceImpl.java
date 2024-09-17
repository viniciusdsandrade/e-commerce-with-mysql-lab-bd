package com.restful.livraria.papelaria.service.impl;

import com.restful.livraria.papelaria.dto.product.DadosAtualizacaoProduto;
import com.restful.livraria.papelaria.dto.product.DadosCadastroProduto;
import com.restful.livraria.papelaria.dto.product.DadosDetalhamentoProduto;
import com.restful.livraria.papelaria.entity.Product;
import com.restful.livraria.papelaria.exception.DuplicateEntryException;
import com.restful.livraria.papelaria.repository.ProductRepository;
import com.restful.livraria.papelaria.service.ProductService;
import com.restful.livraria.papelaria.spec.ProductSpecs;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

import static org.slf4j.LoggerFactory.getLogger;
import static org.springframework.data.jpa.domain.Specification.where;

@Service("productService")
@Schema(description = "Service for managing products")
public class ProductServiceImpl implements ProductService {

    private static final Logger log = getLogger(ProductServiceImpl.class);

    private final ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    @Transactional
    @Schema(description = "Create a new product")
    public Product create(@Valid DadosCadastroProduto dadosCadastroProduto) {
        log.info("Inicio do processo de criação de um novo produto");
        validarCamposDuplicadosEmDadosCadastroProduto(dadosCadastroProduto);
        log.info("Campos duplicados validados com sucesso");

        log.info("Creating a new product");

        Product product = new Product(dadosCadastroProduto);
        productRepository.save(product);
        log.debug("Product created: {}", product);
        return product;
    }

    @Override
    public Product findById(Long id) {
        log.info("Finding product by id: {}", id);
        Product product = existsProductById(id);
        log.debug("Product found: {}", product);
        return product;
    }

    @Override
    @Transactional
    @Schema(description = "Update a product")
    public Product update(@Valid DadosAtualizacaoProduto dadosAtualizacaoProduto) {
        log.info("Updating product with id: {}", dadosAtualizacaoProduto.id());
        Product product = existsProductById(dadosAtualizacaoProduto.id());
        validarCamposDuplicadosEmDadosAtualizacaoProduto(dadosAtualizacaoProduto, product);
        product.update(dadosAtualizacaoProduto);
        productRepository.save(product);
        log.debug("Product updated: {}", product);
        return product;
    }

    @Transactional
    public void lockProduct(Long id) {
        log.info("Locking product with id: {}", id);
        Product product = existsProductById(id);
        validateProductStateForLock(product);
        product.lock();
        log.debug("Product locked: {}", product);
    }

    @Override
    @Transactional
    public void unlockProduct(Long id) {
        log.info("Unlocking product with id: {}", id);
        Product product = existsProductById(id);
        validateProductStateForUnlock(product);
        product.unlock();
        log.debug("Product unlocked: {}", product);
    }

    @Override
    @Schema(description = "List all products")
    public Page<DadosDetalhamentoProduto> listProducts(Pageable pageable) {
        log.info("Listing all products");
        Page<Product> products = productRepository.findAll(pageable);
        log.debug("Products found: {}", products);
        return products.map(DadosDetalhamentoProduto::new);
    }

    @Override
    @Schema(description = "List all available products")
    public Page<DadosDetalhamentoProduto> availableProducts(Pageable pageable) {
        log.info("Listing available products");
        Page<Product> products = productRepository.findByIsActiveTrue(pageable);
        log.debug("Available products found: {}", products);
        return products.map(DadosDetalhamentoProduto::new);
    }

    @Override
    @Schema(description = "List all unavailable products")
    public Page<DadosDetalhamentoProduto> unavailableProducts(Pageable pageable) {
        log.info("Listing unavailable products");
        Page<Product> products = productRepository.findByIsActiveFalse(pageable);
        log.debug("Unavailable products found: {}", products);
        return products.map(DadosDetalhamentoProduto::new);
    }

    @Override
    @Schema(description = "Search products using AND operator")
    public Page<DadosDetalhamentoProduto> searchProductsAnd(
            String name,
            String description,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            boolean isActive,
            List<String> categoriesNames,
            Pageable pageable
    ) {
        log.info("Iniciando pesquisa de produtos com os seguintes critérios (AND):");
        log.info("Nome: {}", name);
        log.info("Descrição: {}", description);
        log.info("Preço mínimo: {}", minPrice);
        log.info("Preço máximo: {}", maxPrice);
        log.info("Ativo: {}", isActive);
        log.info("Nomes das categorias: {}", categoriesNames);

        Specification<Product> spec = where(null);

        spec = addSpecification(spec, name, ProductSpecs::nomeContains, true);
        spec = addSpecification(spec, description, ProductSpecs::descricaoContains, true);
        spec = addSpecification(spec, minPrice, ProductSpecs::precoGreaterThanOrEqual, true);
        spec = addSpecification(spec, maxPrice, ProductSpecs::precoLessThanOrEqual, true);
        spec = addSpecification(spec, isActive, ProductSpecs::isAtivoEquals, true);
        if (categoriesNames != null && !categoriesNames.isEmpty())
            spec = addSpecification(spec, categoriesNames, ProductSpecs::temCategorias, true);

        Page<DadosDetalhamentoProduto> results = productRepository.findAll(spec, pageable)
                .map(DadosDetalhamentoProduto::new);

        log.info("Pesquisa de produtos concluída (AND). Número de resultados encontrados: {}", results.getTotalElements());
        return results;
    }

    @Override
    @Schema(description = "Search products using OR operator")
    public Page<DadosDetalhamentoProduto> searchProductsOr(
            String name,
            String description,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            boolean isActive,
            List<String> categoriesNames,
            Pageable pageable
    ) {
        log.info("Iniciando pesquisa de produtos com os seguintes critérios (OR):");
        log.info("Nome: {}", name);
        log.info("Descrição: {}", description);
        log.info("Preço mínimo: {}", minPrice);
        log.info("Preço máximo: {}", maxPrice);
        log.info("Ativo: {}", isActive);
        log.info("Nomes das categorias: {}", categoriesNames);

        Specification<Product> spec = where(null);

        spec = addSpecification(spec, name, ProductSpecs::nomeContains, false);
        spec = addSpecification(spec, description, ProductSpecs::descricaoContains, false);
        spec = addSpecification(spec, minPrice, ProductSpecs::precoGreaterThanOrEqual, false);
        spec = addSpecification(spec, maxPrice, ProductSpecs::precoLessThanOrEqual, false);
        spec = addSpecification(spec, isActive, ProductSpecs::isAtivoEquals, false);
        if (categoriesNames != null && !categoriesNames.isEmpty())
            spec = addSpecification(spec, categoriesNames, ProductSpecs::temCategorias, false);

        Page<DadosDetalhamentoProduto> results = productRepository.findAll(spec, pageable)
                .map(DadosDetalhamentoProduto::new);

        log.info("Pesquisa de produtos concluída (OR). Número de resultados encontrados: {}", results.getTotalElements());
        return results;
    }

    @Schema(description = "Adiciona uma especificação à especificação atual com base no tipo de junção (AND ou OR).")
    private <T> Specification<Product> addSpecification(
            Specification<Product> spec,
            T value,
            Function<T, Specification<Product>> specBuilder,
            boolean isAnd
    ) {
        return value != null ? (isAnd ? spec.and(specBuilder.apply(value)) : spec.or(specBuilder.apply(value))) : spec;
    }

    @Schema(description = "Verifica se um produto com o ID fornecido existe no banco de dados.")
    private Product existsProductById(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> {
                            log.warn("Carro não encontrado: {}", id);
                            return new EntityNotFoundException("Carro não encontrado");
                        }
                );
    }

    @Schema(description = "Valida se os campos de cadastro de um produto não estão duplicados.")
    private void validarCamposDuplicadosEmDadosCadastroProduto(@Valid DadosCadastroProduto dadosCadastroProduto) {
        List<String> erroDuplicados = new ArrayList<>();

        verificarDuplicidade(dadosCadastroProduto.name(), productRepository.existsByName(dadosCadastroProduto.name()), "Nome", erroDuplicados);

        if (!erroDuplicados.isEmpty()) {
            log.error("Erro de duplicidade encontrado: {}", erroDuplicados);
            throw new DuplicateEntryException("Campos duplicados: " + String.join(", ", erroDuplicados));
        }
    }

    @Schema(description = "Verifica se um valor já existe no banco de dados e adiciona uma mensagem de erro à lista de erros.")
    private void verificarDuplicidade(
            String valor,
            boolean existe,
            String campo,
            List<String> erros
    ) {
        if (existe) {
            log.warn("{} já cadastrado: {}", campo, valor);
            erros.add(campo + " já cadastrado");
        }
    }

    @Schema(description = "Valida se os campos de atualização de um produto não estão duplicados.")
    private void validarCamposDuplicadosEmDadosAtualizacaoProduto(@Valid DadosAtualizacaoProduto dadosAtualizacaoProduto, Product product) {
        List<String> erroDuplicados = new ArrayList<>();

        if (!dadosAtualizacaoProduto.name().equals(product.getName()))
            verificarDuplicidade(dadosAtualizacaoProduto.name(), productRepository.existsByName(dadosAtualizacaoProduto.name()), "Nome", erroDuplicados);

        if (!erroDuplicados.isEmpty()) {
            log.error("Erro de duplicidade encontrado: {}", erroDuplicados);
            throw new DuplicateEntryException("Campos duplicados: " + String.join(", ", erroDuplicados));
        }
    }

    @Schema(description = "Valida se o produto está no estado correto para ser bloqueado.")
    private void validateProductStateForLock(Product product) {
        if (!product.getIsActive()) {
            log.warn("Product already locked: {}", product.getId());
            throw new IllegalStateException("Product already locked");
        }
    }

    @Schema(description = "Valida se o produto está no estado correto para ser desbloqueado.")
    private void validateProductStateForUnlock(Product product) {
        if (product.getIsActive()) {
            log.warn("Product already unlocked: {}", product.getId());
            throw new IllegalStateException("Product already unlocked");
        }
    }
}
