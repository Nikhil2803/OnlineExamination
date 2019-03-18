package com.online.exam.Examination;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages={"com.online.exam.controllers"})
public class ExaminationApplication {

	public static void main(String[] args) {
		SpringApplication.run(ExaminationApplication.class, args);
	}

}

