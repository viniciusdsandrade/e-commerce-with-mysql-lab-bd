package com.restful.livraria.papelaria.dto.product;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.restful.livraria.papelaria.config.BigDecimalCurrencySerializer;
import com.restful.livraria.papelaria.entity.Product;
import io.swagger.v3.oas.annotations.media.Schema;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.restful.livraria.papelaria.dto.category.DadosListagemCategoria;

import static com.fasterxml.jackson.annotation.JsonFormat.Shape.STRING;
import static java.util.stream.Collectors.toList;

@Schema(description = "Dados detalhados de um produto, incluindo suas categorias.")
public record DadosDetalhamentoProduto(

        @Schema(description = "ID do produto")
        Long id,

        @Schema(description = "Nome do produto")
        String name,

        @Schema(description = "Descrição do produto")
        String description,

        @JsonSerialize(using = BigDecimalCurrencySerializer.class)
        @Schema(description = "Preço do produto", type = "number", format = "#,##0.00")
        BigDecimal price,

        @Schema(description = "Status de disponibilidade do produto (true para disponível, false para indisponível)")
        Boolean isActive,

        @JsonFormat(pattern = "dd/MM/yyyy HH:mm:ss", shape = STRING, locale = "pt-BR", timezone = "Brazil/East")
        @Schema(description = "Data de criação do produto")
        LocalDateTime dataCreated,

        @JsonFormat(pattern = "dd/MM/yyyy HH:mm:ss", shape = STRING, locale = "pt-BR", timezone = "Brazil/East")
        @Schema(description = "Data da última atualização do produto")
        LocalDateTime lastUpdated,

        @Schema(description = "Lista de nomes das categorias do produto")
        List<String> categories

) {
    public DadosDetalhamentoProduto(Product product) {
        this(
                product.getId(),
                product.getName(),
                product.getDescription(),
                product.getPrice(),
                product.getIsActive(),
                product.getDataCreated(),
                product.getLastUpdated(),
                product.getCategories()
                        .stream()
                        .map(DadosListagemCategoria::new) // Utiliza o DTO DadosListagemCategoria para evitar loop infinito
                        .map(DadosListagemCategoria::name)
                        .collect(toList())
        );
    }
}
