package com.example.project.repository;

import com.example.project.domain.Food;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoodRepository extends JpaRepository<Food, String> {

    Food save(Food food);
    List<Food> findAll();



}
