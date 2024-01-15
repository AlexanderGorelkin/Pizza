//
//  Dish.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 14.01.2024.
//

import Foundation

struct Dish: Decodable {
    let id,
        name,
        description,
        image: String
    let calories: Int
    
}
