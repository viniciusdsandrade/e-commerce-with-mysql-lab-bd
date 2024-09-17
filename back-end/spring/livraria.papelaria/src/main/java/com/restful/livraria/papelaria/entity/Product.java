package com.restful.livraria.papelaria.entity;

import com.restful.livraria.papelaria.dto.product.DadosAtualizacaoProduto;
import com.restful.livraria.papelaria.dto.product.DadosCadastroProduto;
import jakarta.persistence.*;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.proxy.HibernateProxy;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;
import static java.time.LocalDateTime.now;
import static java.util.Optional.ofNullable;
import static lombok.AccessLevel.NONE;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity(name = "Product")
@Table(
        name = "tb_product",
        schema = "db_papelaria_livraria",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uk_product_name",
                        columnNames = "name"
                )
        }
)
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal price;

    @Column(columnDefinition = "BOOLEAN DEFAULT TRUE")
    @Setter(NONE)
    private Boolean isActive;

    /**
     * Conjunto de categorias às quais este produto pertence.
     * <p>
     * Representa o lado "muitos" no relacionamento muitos-para-muitos com a entidade {@link Category}.
     * Um produto pode pertencer a várias categorias, e a lista de categorias é mapeada através da tabela
     * de junção `tb_produto_categoria`.
     * </p>
     * <p>
     * A anotação `@ManyToMany` indica o relacionamento muitos-para-muitos. O atributo `fetch = LAZY`
     * indica que as categorias serão carregadas sob demanda, apenas quando forem acessadas.
     * </p>
     * <p>
     * A anotação `@JoinTable` define a tabela de junção `tb_produto_categoria` e as colunas
     * que a conectam às tabelas `tb_produto` (através de `joinColumns`) e `tb_categoria`
     * (através de `inverseJoinColumns`).
     * </p>
     * <p>
     * A anotação `@Setter(AccessLevel.NONE)` impede a modificação direta do conjunto de categorias.
     * A manipulação do conjunto deve ser feita por meio de métodos específicos na classe `Product`,
     * garantindo a consistência dos dados.
     * </p>
     * <p>
     * A utilização de `Set` ao invés de `List` garante que não haja categorias duplicadas na lista,
     * já que um produto não pode pertencer à mesma categoria mais de uma vez. Além disso, `Set` não garante
     * a ordem de inserção das categorias, o que é adequado nesse contexto, pois a ordem das categorias
     * às quais um produto pertence não é relevante.
     * </p>
     * <p>
     * A inicialização com `new HashSet<>()` permite que um produto seja criado sem estar inicialmente
     * associado a nenhuma categoria.
     * </p>
     */
    @Setter(NONE)
    @ManyToMany(fetch = LAZY)
    @JoinTable(
            name = "tb_product_category",
            schema = "db_papelaria_livraria_",
            joinColumns = @JoinColumn(name = "id_product"),
            inverseJoinColumns = @JoinColumn(name = "id_category")
    )
    private Set<Category> categories = new HashSet<>();

    @CreationTimestamp
    @Setter(NONE)
    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", nullable = false, updatable = false)
    private LocalDateTime dataCreated;

    @UpdateTimestamp
    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", nullable = false)
    private LocalDateTime lastUpdated;

    public void addCategory(Category category) {
        categories.add(category);
        category.getProducts().add(this);
    }

    public void removeCategory(Category category) {
        categories.remove(category);
        category.getProducts().remove(this);
    }

    public void lock() {
        this.isActive = false;
    }

    public void unlock() {
        this.isActive = true;
    }

    public Product(@Valid DadosCadastroProduto dadosCadastroProduto) {
        this.name = dadosCadastroProduto.name();
        this.description = dadosCadastroProduto.description();
        this.price = dadosCadastroProduto.price();
        ofNullable(dadosCadastroProduto.categoriesIds()).ifPresent(categories -> {
            categories.forEach(categoryId -> {
                Category category = new Category();
                category.setId(categoryId);
                addCategory(category);
            });
        });
        this.isActive = true;
        this.dataCreated = now();
        this.lastUpdated = now();
    }

    public void update(@Valid DadosAtualizacaoProduto dadosCadastroProduto) {
        ofNullable(dadosCadastroProduto.name()).ifPresent(this::setName);
        ofNullable(dadosCadastroProduto.description()).ifPresent(this::setDescription);
        ofNullable(dadosCadastroProduto.price()).ifPresent(this::setPrice);
        ofNullable(dadosCadastroProduto.categoriesIds()).ifPresent(categories -> {
            this.categories.clear();
            categories.forEach(categoryId -> {
                Category category = new Category();
                category.setId(categoryId);
                addCategory(category);
            });
        });
        this.lastUpdated = now();
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

        Product that = (Product) o;

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