package com.example.cinema.config;

import com.example.cinema.account.service.CustomOAuth2UserService;
import com.example.cinema.account.service.UserService;
import com.example.cinema.component.OAuthAuthenticationFailureHandler;
import com.example.cinema.component.OAuthLoginSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private UserService userService;

    @Autowired
    private CustomOAuth2UserService oauth2UserService;

    @Autowired
    private OAuthLoginSuccessHandler oAuthLoginSuccessHandler;

    @Autowired
    private OAuthAuthenticationFailureHandler oAuthAuthenticationFailureHandler;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    public PasswordEncoder getPasswordEncoder(){
        return new BCryptPasswordEncoder(8);
    }

    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }

    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors()
            .and().csrf()
            .and()
                .authorizeRequests()
                    .antMatchers("/registration").not().fullyAuthenticated()
                    .antMatchers("/", "/static/**", "/confirm/*", "/navigator/**", "/item/**", "/star/**").permitAll()
                    .antMatchers("/user/**", "/cinemas", "/cinema/**", "/seance/**", "/reservation/**", "/oauth2/**").permitAll()
                    .antMatchers("/forgot-password", "/reset-password/**").not().fullyAuthenticated()
                    .antMatchers("/admin/**").hasAnyAuthority("ADMIN", "OWNER")
                    .anyRequest().authenticated()
            .and()
                .formLogin()
                .loginPage("/login")
                .defaultSuccessUrl("/")
                .failureUrl("/login?error=true")
                .permitAll()
            .and()
                .oauth2Login()
                .loginPage("/login")
                .userInfoEndpoint()
                .userService(oauth2UserService)
            .and()
                .successHandler(oAuthLoginSuccessHandler)
                .failureHandler(oAuthAuthenticationFailureHandler)
            .and()
                .rememberMe()
            .and()
                .logout()
                .permitAll()
                .logoutSuccessUrl("/")
            .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                .invalidSessionUrl("/")
            .and()
                .sessionManagement()
                .maximumSessions(100)
                .sessionRegistry(sessionRegistry())
                .expiredUrl("/login");
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder);
    }
}