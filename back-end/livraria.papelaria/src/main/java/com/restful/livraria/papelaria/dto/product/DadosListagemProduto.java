package com.restful.livraria.papelaria.dto.product;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.restful.livraria.papelaria.config.BigDecimalCurrencySerializer;
import com.restful.livraria.papelaria.entity.Product;
import io.swagger.v3.oas.annotations.media.Schema;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static com.fasterxml.jackson.annotation.JsonFormat.Shape.STRING;

@Schema(description = "Dados para listagem de um produto")
public record DadosListagemProduto(

        @Schema(description = "Nome do produto")
        String name,

        @Schema(description = "Status de disponibilidade do produto (true para disponível, false para indisponível)")
        Boolean isActive,

        @JsonSerialize(using = BigDecimalCurrencySerializer.class)
        @Schema(description = "Preço do produto", type = "number", format = "#,##0.00")
        BigDecimal price,

        @JsonFormat(pattern = "dd/MM/yyyy HH:mm:ss", shape = STRING, locale = "pt-BR", timezone = "Brazil/East")
        @Schema(description = "Data da última atualização do produto")
        LocalDateTime lastUpdated
) {

    public DadosListagemProduto(Product product) {
        this(
                product.getName(),
                product.getPrice(),
                product.getIsActive(),
                product.getLastUpdated()
        );
    }

    public DadosListagemProduto(
            String name,
            BigDecimal price,
            Boolean isActive,
            LocalDateTime lastUpdated) {
        this(name, isActive, price, lastUpdated);
    }
}
