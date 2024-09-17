package com.restful.livraria.papelaria.spec;

import com.restful.livraria.papelaria.entity.Category;
import com.restful.livraria.papelaria.entity.Product;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.criteria.Join;
import org.springframework.data.jpa.domain.Specification;


/**
 * Classe utilitária para criar especificações JPA para a entidade {@link Category}.
 * <p>
 * Esta classe fornece métodos estáticos que retornam objetos {@link Specification}
 * para construir consultas dinâmicas para a entidade {@link Category},
 * permitindo a pesquisa de categorias com base em diferentes critérios.
 * </p>
 */
@Schema(description = "Classe utilitária para criar especificações JPA para a entidade Category.")
public class CategorySpecs {

    /**
     * Cria uma especificação para pesquisar categorias cujo name contenha o valor especificado.
     *
     * @param nome O valor a ser pesquisado no name da categoria.
     * @return A especificação JPA para a pesquisa por name.
     */
    @Schema(description = "Cria uma especificação para pesquisar categorias cujo name contenha o valor especificado.")
    public static Specification<Category> nomeContains(String nome) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.like(root.get("name"), "%" + nome + "%");
    }

    /**
     * Cria uma especificação para pesquisar categorias com o name exatamente igual ao valor especificado.
     *
     * @param nome O name exato da categoria a ser pesquisada.
     * @return A especificação JPA para a pesquisa por name exato.
     */
    @Schema(description = "Cria uma especificação para pesquisar categorias com o name exatamente igual ao valor especificado.")
    public static Specification<Category> nomeEquals(String nome) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.equal(root.get("name"), nome);
    }

    /**
     * Cria uma especificação para pesquisar categorias que tenham pelo menos um produto associado.
     *
     * @return A especificação JPA para a pesquisa por categorias com pelo menos um produto.
     */
    @Schema(description = "Cria uma especificação para pesquisar categorias que tenham pelo menos um produto associado.")
    public static Specification<Category> temProdutos() {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.isNotEmpty(root.get("products"));
    }

    /**
     * Cria uma especificação para pesquisar categorias que não tenham nenhum produto associado.
     *
     * @return A especificação JPA para a pesquisa por categorias sem produtos.
     */
    @Schema(description = "Cria uma especificação para pesquisar categorias que não tenham nenhum produto associado.")
    public static Specification<Category> naoTemProdutos() {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.isEmpty(root.get("products"));
    }

    /**
     * Cria uma especificação para pesquisar categorias que tenham um número mínimo de produtos associados.
     *
     * @param numeroMinimoProdutos O número mínimo de produtos que a categoria deve ter.
     * @return A especificação JPA para a pesquisa por categorias com número mínimo de produtos.
     */
    @Schema(description = "Cria uma especificação para pesquisar categorias que tenham um número mínimo de produtos associados.")
    public static Specification<Category> numeroMinimoProdutos(int numeroMinimoProdutos) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.ge(criteriaBuilder.size(root.get("products")), numeroMinimoProdutos);
    }

    /**
     * Cria uma especificação para pesquisar categorias que tenham um número máximo de produtos associados.
     *
     * @param numeroMaximoProdutos O número máximo de produtos que a categoria deve ter.
     * @return A especificação JPA para a pesquisa por categorias com número máximo de produtos.
     */
    @Schema(description = "Cria uma especificação para pesquisar categorias que tenham um número máximo de produtos associados.")
    public static Specification<Category> numeroMaximoProdutos(int numeroMaximoProdutos) {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.le(criteriaBuilder.size(root.get("products")), numeroMaximoProdutos);
    }

    /**
     * Cria uma especificação para pesquisar categorias que tenham produtos com nomes que contenham um determinado valor.
     *
     * @param nomeProduto O valor a ser pesquisado nos nomes dos produtos da categoria.
     * @return A especificação JPA para a pesquisa por categorias com produtos que contenham o name especificado.
     */
    @Schema(description = "Cria uma especificação para pesquisar categorias que tenham produtos com nomes que contenham um determinado valor.")
    public static Specification<Category> produtosNomeContains(String nomeProduto) {
        return (root, query, criteriaBuilder) -> {
            Join<Category, Product> produtosJoin = root.join("products");
            return criteriaBuilder.like(produtosJoin.get("name"), "%" + nomeProduto + "%");
        };
    }
}