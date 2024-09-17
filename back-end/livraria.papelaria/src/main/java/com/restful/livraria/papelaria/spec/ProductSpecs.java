package com.restful.livraria.papelaria.spec;

import com.restful.livraria.papelaria.entity.Category;
import com.restful.livraria.papelaria.entity.Product;
import io.swagger.v3.oas.annotations.media.Schema;
import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.*;

import java.math.BigDecimal;
import java.util.List;

/**
 * Classe utilitária para criar especificações JPA para a entidade {@link Product}.
 * <p>
 * Esta classe fornece métodos estáticos que retornam objetos {@link Specification}
 * para construir consultas dinâmicas para a entidade {@link Product},
 * permitindo a pesquisa de produtos com base em diferentes critérios.
 * </p>
 */
@Schema(description = "Classe utilitária para criar especificações JPA para a entidade Product.")
public class ProductSpecs {

    /**
     * Cria uma especificação para pesquisar produtos cujo name contenha o valor especificado.
     *
     * @param nome O valor a ser pesquisado no name do produto.
     * @return A especificação JPA para a pesquisa por name.
     */
    @Schema(description = "Cria uma especificação para pesquisar produtos cujo name contenha o valor especificado.")
    public static Specification<Product> nomeContains(String nome) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.like(root.get("name"), "%" + nome + "%");
    }

    /**
     * Cria uma especificação para pesquisar produtos com o preço igual ao valor especificado.
     *
     * @param preco O preço do produto a ser pesquisado.
     * @return A especificação JPA para a pesquisa por preço.
     */
    @Schema(description = "Cria uma especificação para pesquisar produtos com o preço igual ao valor especificado.")
    public static Specification<Product> precoEquals(BigDecimal preco) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.equal(root.get("preco"), preco);
    }

    /**
     * Cria uma especificação para pesquisar produtos com preço maior ou igual ao valor especificado.
     *
     * @param precoMin O preço mínimo do produto a ser considerado na pesquisa.
     * @return A especificação JPA para a pesquisa por preço mínimo.
     */
    @Schema(description = "Cria uma especificação para pesquisar produtos com preço maior ou igual ao valor especificado.")
    public static Specification<Product> precoGreaterThanOrEqual(BigDecimal precoMin) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.greaterThanOrEqualTo(root.get("preco"), precoMin);
    }

    /**
     * Cria uma especificação para pesquisar produtos com preço menor ou igual ao valor especificado.
     *
     * @param precoMax O preço máximo do produto a ser considerado na pesquisa.
     * @return A especificação JPA para a pesquisa por preço máximo.
     */
    @Schema(description = "Cria uma especificação para pesquisar produtos com preço menor ou igual ao valor especificado.")
    public static Specification<Product> precoLessThanOrEqual(BigDecimal precoMax) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.lessThanOrEqualTo(root.get("preco"), precoMax);
    }

    /**
     * Cria uma especificação para pesquisar produtos cuja descrição contenha o valor especificado.
     *
     * @param descricao O valor a ser pesquisado na descrição do produto.
     * @return A especificação JPA para a pesquisa por descrição.
     */
    @Schema(description = "Cria uma especificação para pesquisar produtos cuja descrição contenha o valor especificado.")
    public static Specification<Product> descricaoContains(String descricao) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.like(root.get("descricao"), "%" + descricao + "%");
    }

    /**
     * Cria uma especificação para pesquisar produtos com a disponibilidade (isAtivo) especificada.
     *
     * @param isAtivo A disponibilidade do produto a ser pesquisada (true para disponível, false para indisponível).
     * @return A especificação JPA para a pesquisa por disponibilidade.
     */
    @Schema(description = "Cria uma especificação para pesquisar produtos com a disponibilidade (isAtivo) especificada.")
    public static Specification<Product> isAtivoEquals(Boolean isAtivo) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.equal(root.get("isAtivo"), isAtivo);
    }

    /**
     * Cria uma especificação para pesquisar produtos que pertençam a pelo menos uma das categorias especificadas.
     *
     * @param categoriasNomes A lista de nomes de categorias a serem pesquisadas.
     * @return A especificação JPA para a pesquisa por categorias.
     */
    @Schema(description = "Cria uma especificação para pesquisar produtos que pertençam a pelo menos uma das categorias especificadas.")
    public static Specification<Product> temCategorias(List<String> categoriasNomes) {
        return (root, query, criteriaBuilder) -> {
            Join<Product, Category> categoriasJoin = root.join("categories");
            return criteriaBuilder.or(categoriasNomes.stream()
                    .map(nome -> criteriaBuilder.equal(categoriasJoin.get("name"), nome))
                    .toArray(Predicate[]::new));
        };
    }
}