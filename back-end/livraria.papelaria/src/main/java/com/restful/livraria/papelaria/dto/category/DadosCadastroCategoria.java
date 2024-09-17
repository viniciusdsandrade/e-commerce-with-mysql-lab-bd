package com.restful.livraria.papelaria.dto.category;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Schema(description = "Dados para cadastro de uma categoria")
public record DadosCadastroCategoria(

        @NotBlank(message = "O nome da categoria é obrigatório")
        @Size(min = 3, max = 80, message = "O nome da categoria deve ter entre 3 e 80 caracteres")
        @Schema(description = "Nome da categoria")
        String name
) {
}
