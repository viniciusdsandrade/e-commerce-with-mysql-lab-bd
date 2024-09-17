package com.restful.livraria.papelaria.dto.product;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;
import java.util.Set;

@Schema(description = "Dados para atualização de um produto")
public record DadosAtualizacaoProduto(

        @NotEmpty(message = "O ID do produto não pode ser nulo")
        @Schema(description = "ID do produto")
        Long id,

        @Schema(description = "Nome do produto")
        @Size(min = 1, max = 60, message = "O nome do produto deve ter entre 1 e 60 caracteres")
        String name,

        @Schema(description = "Descrição do produto")
        @Size(min = 1, max = 255, message = "A descrição do produto deve ter entre 1 e 255 caracteres")
        String description,

        @DecimalMax(value = "9999999.99", message = "O preço do produto deve ser menor que R$ 9.999.999,00")
        @DecimalMin(value = "0.00", inclusive = false, message = "O preço do produto deve ser maior que zero")
        @Schema(description = "Preço do produto", type = "number", format = "#,##0.00")
        BigDecimal price,

        @NotEmpty(message = "O produto deve ter pelo menos uma categoria associada")
        @Size(min = 1, message = "O produto deve ter pelo menos uma categoria associada")
        @Schema(description = "IDs das categorias às quais o produto pertence")
        Set<Long> categoriesIds
) {
}