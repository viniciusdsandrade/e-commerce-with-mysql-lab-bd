package com.restful.livraria.papelaria.service;


import com.restful.livraria.papelaria.repository.ProductRepository;
import com.restful.livraria.papelaria.service.impl.ProductServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.test.context.ActiveProfiles;

import static org.mockito.Mockito.mock;

@ActiveProfiles("ProductServiceTest")
public class ProductServiceTest {

    private ProductService productService;
    private ProductRepository productRepository;

    @BeforeEach
    public void setUp() {
        productRepository = mock(ProductRepository.class);
        productService = new ProductServiceImpl(productRepository);
    }
}
