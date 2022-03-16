package com.example.cinema.config;

import com.example.cinema.component.interceptor.LoadContentInterceptor;
import com.example.cinema.component.interceptor.VerifyAccessInterceptor;
import com.example.cinema.utils.RedirectInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {
    @Autowired
    private VerifyAccessInterceptor verifyAccessInterceptor;

    @Autowired
    private LoadContentInterceptor loadContentInterceptor;

    @Bean
    public RestTemplate getRestTemplate() {
        return new RestTemplate();
    }

    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/login").setViewName("login");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new RedirectInterceptor());
        registry.addInterceptor(verifyAccessInterceptor).addPathPatterns("/**");
        registry.addInterceptor(loadContentInterceptor).addPathPatterns("/**");
    }
}