package com.restful.livraria.papelaria.dto.category;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Schema(description = "Dados para atualização de uma categoria")
public record DadosAtualizacaoCategoria(

        @NotEmpty(message = "O ID da categoria não pode ser nulo")
        @Schema(description = "ID da categoria")
        Long id,

        @Schema(description = "Nome da categoria")
        @Size(min = 1, max = 60, message = "O nome da categoria deve ter entre 1 e 60 caracteres")
        String name
) {
}
