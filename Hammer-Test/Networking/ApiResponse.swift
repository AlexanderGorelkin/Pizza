//
//  ApiResponse.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 14.01.2024.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
