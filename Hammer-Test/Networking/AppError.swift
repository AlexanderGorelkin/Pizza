//
//  AppError.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 14.01.2024.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Запрос не может быть расшифрован"
        case .unknownError:
            return "Не знаю, что за ошибка"
        case .invalidUrl:
            return "Неправильная ссылка"
        case .serverError(let error):
            return error
        }
    }
}
