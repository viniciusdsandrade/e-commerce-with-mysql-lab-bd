package com.restful.livraria.papelaria.dto.category;

import com.restful.livraria.papelaria.entity.Category;
import io.swagger.v3.oas.annotations.media.Schema;

import static java.lang.String.valueOf;

@Schema(description = "Dados para listagem de uma categoria")
public record DadosListagemCategoria(
        String name
) {
    public DadosListagemCategoria(Category name) {
        this(valueOf(name.getName()));
    }
}
