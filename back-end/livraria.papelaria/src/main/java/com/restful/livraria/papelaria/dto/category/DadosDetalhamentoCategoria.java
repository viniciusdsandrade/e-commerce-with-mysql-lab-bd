package com.restful.livraria.papelaria.dto.category;

import com.restful.livraria.papelaria.dto.product.DadosListagemProduto;
import com.restful.livraria.papelaria.entity.Category;
import com.restful.livraria.papelaria.entity.Product;

import java.util.List;

import static java.util.stream.Collectors.toList;

public record DadosDetalhamentoCategoria(
        Long id,
        String name,
        List<String> productsNames
) {

    public DadosDetalhamentoCategoria(Category category) {
        this(
                category.getId(),
                category.getName(),
                category.getProducts()
                        .stream()
                        .map(DadosListagemProduto::new)
                        .map(DadosListagemProduto::name)
                        .collect(toList())
        );
    }
}
