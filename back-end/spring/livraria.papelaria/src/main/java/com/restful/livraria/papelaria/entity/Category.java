package com.restful.livraria.papelaria.entity;

import com.restful.livraria.papelaria.dto.category.DadosAtualizacaoCategoria;
import com.restful.livraria.papelaria.dto.category.DadosCadastroCategoria;
import jakarta.persistence.*;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.proxy.HibernateProxy;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;
import static java.util.Optional.ofNullable;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity(name = "Category")
@Table(
        name = "tb_category",
        schema = "db_papelaria_livraria",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uk_category_name",
                        columnNames = "name"
                )
        }
)
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String name;

    /**
     * Conjunto de produtos que pertencem a esta categoria.
     * <p>
     * Representa o lado "muitos" no relacionamento muitos-para-muitos com a entidade {@link Product}.
     * Uma categoria pode conter vários produtos, e a lista de produtos é mapeada através da tabela
     * de junção `tb_produto_categoria`.
     * </p>
     * <p>
     * A anotação `@ManyToMany(mappedBy = "categories")` indica que a relação é gerenciada pela
     * entidade `Product`, através do atributo `categories` na classe `Product`. Isso significa que
     * as operações de persistência relacionadas a essa relação serão realizadas a partir da entidade `Product`.
     * </p>
     * <p>
     * O atributo `fetch = LAZY` indica que os produtos serão carregados sob demanda, apenas quando forem acessados.
     * </p>
     * <p>
     * A utilização de `Set` ao invés de `List` garante que não haja produtos duplicados na lista,
     * já que um produto não pode pertencer à mesma categoria mais de uma vez. Além disso, `Set` não garante
     * a ordem de inserção dos produtos, o que é adequado nesse contexto, pois a ordem dos produtos
     * que pertencem a uma categoria não é relevante.
     * </p>
     * <p>
     * A inicialização com `new HashSet<>()` permite que uma categoria seja criada sem estar inicialmente
     * associada a nenhum produto.
     * </p>
     */
    @ManyToMany(mappedBy = "categories", fetch = LAZY)
    private Set<Product> products = new HashSet<>();

    public Category(@Valid DadosCadastroCategoria dadosCadastroCategoria) {
        this.name = dadosCadastroCategoria.name();
    }

    public void update(@Valid DadosAtualizacaoCategoria dadosAtualizacaoCategoria) {
        ofNullable(dadosAtualizacaoCategoria.name())
                .ifPresent(this::setName);

    }

    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;

        Class<?> oEffectiveClass = o instanceof HibernateProxy
                ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass()
                : o.getClass();

        Class<?> thisEffectiveClass = this instanceof HibernateProxy
                ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass()
                : this.getClass();

        if (thisEffectiveClass != oEffectiveClass) return false;

        Category that = (Category) o;

        return getId() != null &&
               Objects.equals(this.getId(), that.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy
                ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode()
                : getClass().hashCode();
    }


}
