package com.restful.livraria.papelaria.service;

import com.restful.livraria.papelaria.repository.CategoryRepository;
import com.restful.livraria.papelaria.service.impl.CategoryServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.test.context.ActiveProfiles;

import static org.mockito.Mockito.mock;

@ActiveProfiles("CategoryServiceTest")
public class CategoryServiceTest {

    private CategoryService categoryService;
    private CategoryRepository categoryRepository;

    @BeforeEach
    public void setUp() {
        categoryRepository = mock(CategoryRepository.class);
        categoryService = new CategoryServiceImpl(categoryRepository);
    }
}
