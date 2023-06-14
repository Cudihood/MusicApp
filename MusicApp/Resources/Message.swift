//
//  Message.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 12.06.2023.
//

import Foundation

enum Message
{
    enum Error {
        static let errorConverting = NSError(domain: "com.urlConvert.app",
                                             code: 0,
                                             userInfo: [NSLocalizedDescriptionKey: "Error converting text to URL"])
        static let errorInvalidResponse = NSError(domain: "com.network.app",
                                   code: 0,
                                   userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"])
        
        static func errorHTTP(statusCode: Int) -> NSError{
            NSError(domain: "com.network.app", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "\(ResponseСode.init(statusCode: statusCode).rawValue)"])
        }
    }
    
    enum ResponseСode: String {
        case success = "Запрос успешно выполнен."
        case badRequest = "Некорректный запрос."
        case unauthorized = "Неавторизованный доступ."
        case forbidden = "Доступ запрещен."
        case notFound = "Запрашиваемый ресурс не найден."
        case tooManyRequests = "Превышено ограничение на количество запросов."
        case internalServerError = "Внутренняя ошибка сервера."
        case serviceUnavailable = "Сервис недоступен."
        case unknown = "Неизвестный код ответа."
        
        init(statusCode: Int) {
            switch statusCode {
            case 200:
                self = .success
            case 400:
                self = .badRequest
            case 401:
                self = .unauthorized
            case 403:
                self = .forbidden
            case 404:
                self = .notFound
            case 429:
                self = .tooManyRequests
            case 500:
                self = .internalServerError
            case 503:
                self = .serviceUnavailable
            default:
                self = .unknown
            }
        }
    }
}
