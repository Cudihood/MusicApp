//
//  Constants.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit

enum Constants {
    static let dynamicTextColor = UIColor { (traitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
    
    static let baseURL = "https://itunes.apple.com/search?entity=song&term="
    
    enum Error {
        static let errorConverting = NSError(domain: "com.urlConvert.app",
                                             code: 0,
                                             userInfo: [NSLocalizedDescriptionKey: "Error converting text to URL"])
        static let errorInvalidResponse = NSError(domain: "com.network.app",
                                   code: 0,
                                   userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"])
        
        static func errorHTTP(statusCode: Int) -> NSError{
            NSError(domain: "com.network.app", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(ResponseСode.init(statusCode: statusCode))"])
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
    
    enum Spacing {
        static let standart = 16
        static let little = 6
    }
    
    enum Size {
        static let little = 60
        static let big = 200
        static let cornerRadius: CGFloat = 20
    }
    
    enum Font {
        static let title1 = UIFont.preferredFont(forTextStyle: .title1)
        static let title2 = UIFont.preferredFont(forTextStyle: .title2)
        static let title3 = UIFont.preferredFont(forTextStyle: .title3)
        static let body = UIFont.preferredFont(forTextStyle: .body)
    }
    
    enum Color {
        static let systemBlue = UIColor.systemBlue
        static let systemBackground = UIColor.systemBackground
    }
}
