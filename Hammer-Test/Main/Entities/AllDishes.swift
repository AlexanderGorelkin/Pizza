//
//  AllDishes.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 14.01.2024.
//

import Foundation


struct AllDishes: Decodable {
    let categories: [DishCategory]
    let populars: [Dish]
    let specials: [Dish]
}
