package com.kkn.www.food;

import com.kkn.www.entity.Food;
import com.kkn.www.repository.FoodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FoodService {
    private final FoodRepository foodRepository;

    @Autowired
    public FoodService(FoodRepository foodRepository) {
        this.foodRepository = foodRepository;
    }

    public Food getFoodByFoodCode(Integer foodcode) {
        return foodRepository.findById(foodcode).orElse(null);
    }
}
