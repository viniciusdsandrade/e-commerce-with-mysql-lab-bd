package com.restful.livraria.papelaria.dto.product;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Column;
import jakarta.validation.constraints.*;

import java.math.BigDecimal;
import java.util.Set;

@Schema(description = "Dados para cadastro de um produto")
public record DadosCadastroProduto(

        @NotBlank(message = "O nome do produto é obrigatório")
        @Size(min = 3, max = 80, message = "O nome do produto deve ter entre 3 e 80 caracteres")
        @Schema(description = "Nome do produto")
        String name,

        @Schema(description = "Descrição do produto")
        @Size(min = 1, max = 255, message = "A descrição do produto deve ter entre 1 e 255 caracteres")
        String description,

        @DecimalMax(value = "9999999.99", message = "O preço do produto deve ser menor que R$ 9.999.999,00")
        @DecimalMin(value = "0.00", inclusive = false, message = "O preço do produto deve ser maior que zero")
        @NotNull(message = "O preço do produto é obrigatório")
        @Schema(description = "Preço do produto", type = "number", format = "#,##0.00")
        BigDecimal price,

        @Schema(description = "IDs das categorias às quais o produto pertence")
        Set<Long> categoriesIds
) {
}
