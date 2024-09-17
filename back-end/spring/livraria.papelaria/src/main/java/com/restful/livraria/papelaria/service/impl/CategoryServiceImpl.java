package com.restful.livraria.papelaria.service.impl;

import com.restful.livraria.papelaria.dto.category.DadosAtualizacaoCategoria;
import com.restful.livraria.papelaria.dto.category.DadosCadastroCategoria;
import com.restful.livraria.papelaria.dto.category.DadosDetalhamentoCategoria;
import com.restful.livraria.papelaria.entity.Category;
import com.restful.livraria.papelaria.exception.DuplicateEntryException;
import com.restful.livraria.papelaria.repository.CategoryRepository;
import com.restful.livraria.papelaria.service.CategoryService;
import com.restful.livraria.papelaria.spec.CategorySpecs;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

import static org.slf4j.LoggerFactory.getLogger;
import static org.springframework.data.jpa.domain.Specification.where;

@Service("categoryService")
@Schema(description = "Service for managing categories")
public class CategoryServiceImpl implements CategoryService {

    private static final Logger log = getLogger(CategoryServiceImpl.class);

    private final CategoryRepository categoryRepository;

    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    @Transactional
    @Schema(description = "Create a new category")
    public Category create(@Valid DadosCadastroCategoria dadosCadastroCategoria) {
        log.info("Inicio do processo de criação de uma nova categoria");
        validarCamposDuplicadosEmDadosCadastroCategoria(dadosCadastroCategoria);
        log.info("Campos duplicados validados com sucesso");

        log.info("Creating a new category");

        Category category = new Category(dadosCadastroCategoria);
        categoryRepository.save(category);
        log.debug("Category created: {}", category);
        return category;
    }

    @Override
    public Category findById(Long id) {
        log.info("Finding category by id: {}", id);
        Category category = existsCategoryById(id);
        log.debug("Category found: {}", category);
        return category;
    }

    @Override
    @Transactional
    @Schema(description = "Update an existing category")
    public Category update(@Valid DadosAtualizacaoCategoria dadosAtualizacaoCategoria) {
        log.info("Updating category with id: {}", dadosAtualizacaoCategoria.id());
        Category category = existsCategoryById(dadosAtualizacaoCategoria.id());
        validarCamposDuplicadosEmDadosAtualizacaoCategoria(dadosAtualizacaoCategoria, category);
        category.update(dadosAtualizacaoCategoria);
        categoryRepository.save(category);
        log.debug("Category updated: {}", category);
        return category;
    }

    @Override
    @Schema(description = "List all categories")
    public Page<DadosDetalhamentoCategoria> listCategories(Pageable pageable) {
        log.info("Listing all categories");
        Page<Category> categories = categoryRepository.findAll(pageable);
        log.debug("Categories found: {}", categories);
        return categories.map(DadosDetalhamentoCategoria::new);
    }

    @Override
    @Schema(description = "Search categories using AND operator")
    public Page<DadosDetalhamentoCategoria> searchCategoriesAnd(
            String name,
            Pageable pageable
    ) {
        log.info("Iniciando pesquisa de categorias com os seguintes critérios (AND):");
        log.info("Nome: {}", name);

        Specification<Category> spec = where(null);

        spec = addSpecification(spec, name, CategorySpecs::nomeContains, true);

        Page<DadosDetalhamentoCategoria> results = categoryRepository.findAll(spec, pageable)
                .map(DadosDetalhamentoCategoria::new);

        log.info("Pesquisa de categorias concluída (AND). Número de resultados encontrados: {}", results.getTotalElements());
        return results;
    }

    @Override
    @Schema(description = "Search categories using OR operator")
    public Page<DadosDetalhamentoCategoria> searchCategoriesOr(
            String name,
            Pageable pageable
    ) {
        log.info("Iniciando pesquisa de categorias com os seguintes critérios (OR):");
        log.info("Nome: {}", name);

        Specification<Category> spec = where(null);

        spec = addSpecification(spec, name, CategorySpecs::nomeContains, false);

        Page<DadosDetalhamentoCategoria> results = categoryRepository.findAll(spec, pageable)
                .map(DadosDetalhamentoCategoria::new);

        log.info("Pesquisa de categorias concluída (OR). Número de resultados encontrados: {}", results.getTotalElements());
        return results;
    }

    @Schema(description = "Adiciona uma especificação à especificação atual com base no tipo de junção (AND ou OR).")
    private <T> Specification<Category> addSpecification(
            Specification<Category> spec,
            T value,
            Function<T, Specification<Category>> specBuilder,
            boolean isAnd
    ) {
        return value != null ? (isAnd ? spec.and(specBuilder.apply(value)) : spec.or(specBuilder.apply(value))) : spec;
    }

    @Schema(description = "Verifica se uma categoria com o ID fornecido existe no banco de dados.")
    private Category existsCategoryById(Long id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> {
                            log.warn("Categoria não encontrada: {}", id);
                            return new EntityNotFoundException("Categoria não encontrada");
                        }
                );
    }

    @Schema(description = "Valida se os campos de cadastro de uma categoria não estão duplicados.")
    private void validarCamposDuplicadosEmDadosCadastroCategoria(@Valid DadosCadastroCategoria dadosCadastroCategoria) {
        List<String> erroDuplicados = new ArrayList<>();

        verificarDuplicidade(dadosCadastroCategoria.name(), categoryRepository.existsByName(dadosCadastroCategoria.name()), "Nome", erroDuplicados);

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

    @Schema(description = "Valida se os campos de atualização de uma categoria não estão duplicados.")
    private void validarCamposDuplicadosEmDadosAtualizacaoCategoria(@Valid DadosAtualizacaoCategoria dadosAtualizacaoCategoria, Category category) {
        List<String> erroDuplicados = new ArrayList<>();

        if (!dadosAtualizacaoCategoria.name().equals(category.getName()))
            verificarDuplicidade(dadosAtualizacaoCategoria.name(), categoryRepository.existsByName(dadosAtualizacaoCategoria.name()), "Nome", erroDuplicados);

        if (!erroDuplicados.isEmpty()) {
            log.error("Erro de duplicidade encontrado: {}", erroDuplicados);
            throw new DuplicateEntryException("Campos duplicados: " + String.join(", ", erroDuplicados));
        }
    }
}
