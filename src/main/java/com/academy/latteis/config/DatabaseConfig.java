package com.academy.latteis.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import javax.sql.DataSource;

@Configuration
@PropertySource("classpath:db_info.properties")
public class DatabaseConfig {
    @Value("${local.db.username}")
    private String username;

    @Value("${local.db.password}")
    private String password;

    @Value("${local.db.url}")
    private String url;

    @Bean
    public DataSource dataSource(){ // <bean id="dataSource"
        HikariConfig config = new HikariConfig();
        config.setUsername(username);
        config.setPassword(password);
        config.setJdbcUrl(url);
        config.setDriverClassName("org.mariadb.jdbc.Driver");

        return new HikariDataSource(config);
    }
}