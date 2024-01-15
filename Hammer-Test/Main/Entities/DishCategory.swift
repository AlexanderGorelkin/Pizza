//
//  DishCategory.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 14.01.2024.
//

import Foundation

struct DishCategory: Decodable {
    let id, name, image: String
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}
